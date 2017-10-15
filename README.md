# MiddleDomain

Common logic for domain layer on rails.

Exists logic is,

- pointable

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'middledomain'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middledomain

## Usage for "pointable"

### Add database schema.

Your database must some tables.

##### user_statuses example.

```
CREATE TABLE `user_statuses` (
  id ・・・,
  user_id ・・・,
  point integer not null default 0
);
```

##### user_points example.

```
CREATE TABLE `user_points` (
  id ・・・,
  user_id ・・・,
  current_value integer not null,
);
```

#### user_point_histories example.

```
CREATE TABLE `user_statuses` (
  id ・・・,
  user_id ・・・,
  user_point_id integer not null,
  current_value integer not null,
  value integer not null, # Increate point value or Decrease point value(1,2,3,-1,-2,-3 ...etc).
);
```

### Source Code

##### app/models/user.rb

```
class User < ApplicationRecord
  middledomain :pointable
  has_one :status, class_name: 'UserStatus'
  has_many :points, class_name: 'UserPoint'
end
```

```
class UserPoint < ApplicationRecord
  has_many :histories, class_name: 'UserPointHistory'
end
```

**user** model got 2 methods.

- increase_point
- decrease_point


