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
