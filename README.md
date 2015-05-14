[![Build Status](https://travis-ci.org/mntnorv/to_lua.svg)](https://travis-ci.org/mntnorv/to_lua)

# to_lua
Serialize Ruby objects to lua tables

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'to_lua'
```

And then execute:

    $ bundle

Or install it manually with:

    $ gem install to_lua

## Usage

```ruby
{a: 'hash'}.to_lua       # {["a"]="hash"}
[:some, :array].to_lua   # {"some","array"}
"\nStr\"ing\x00".to_lua  # "\nStr\"ing\0"
123456.to_lua            # 123456
3.14159.to_lua           # 3.14159
true.to_lua              # true
false.to_lua             # false
nil.to_lua               # nil
```

## Custom objects

Custom objects can define `as_lua` method. The return value will be serialized
with `to_lua`. Example:

```ruby
class CustomObject
  def as_lua
    { lua: 'object' }
  end
end

CustomObject.new.to_lua  # {["lua"]="object"}
```

If an object does not define the `as_lua` method, `to_s` will be used instead
and the object will be serialized as a string.
