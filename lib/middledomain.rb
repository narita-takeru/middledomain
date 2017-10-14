require "middledomain/version"

require "active_record"
require "active_support/concern"

module Middledomain

  module Models

    def middledomain(m)
      include Middledomain::Models.const_get(m.to_s.classify)
    end

    module Pointable

      extend ActiveSupport::Concern

      def increase_point(value)
        point = self.points.build(current_value: value, got_value: value)
        point.histories.build(
          user_id: point.user_id,
          user_point_id: point.id,
          current_value: value,
          value: value
        )

        self.status.point = self.status.point + value

        point.save!
        point.histories[0].save!
        self.status.save!
      end

      def decrease_point(value)

        if self.status.point < value
          return nil
        end

        conn = ActiveRecord::Base.connection
        now = conn.select_one("select now() as now")["now"]

        while 0 < value

          point = self.points.where("expired_at is null or expired_at < ?", now).where("0 < current_value").order(:created_at).first
          if point.nil?
            raise "Does't exist available user_point record"
          end

          if value <= point.current_value
            decrease = value
          else
            decrease = point.current_value
          end

          point.current_value = point.current_value - decrease

          point.histories.build(
            user_id: point.user_id,
            user_point_id: point.id,
            current_value: point.current_value,
            value: -decrease
          )

          point.save!
          point.histories[0].save!
          self.status.point = self.status.point - decrease
          value = value - decrease
        end

        self.status.save!
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  extend Middledomain::Models
end
