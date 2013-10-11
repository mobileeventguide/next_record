# NextRecord

Extends ActiveRecord by adding `next` and `previous` instance methods, returning
the next and previous record according to a predefined order.

## Installation

Add this line to your application's Gemfile:

    gem 'next_record'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install next_record

## Usage

Define an order in your model, using `next_record_order`. It takes the same
arguments as ActiveRecord's `order` method:

```ruby
class Person < ActiveRecord::Base
  next_record_order 'lower(trim(last_name))', :id
end
```

Find the previous and next records:

```ruby
e = Person.first
e.next # => next record according to the defined order
e.previous # => previous record according to the defined order
```

## TODO

* Write tests... (so far it is tested in an app it is used in)
