require_relative 'to_lua/extensions'

class Hash
  include ToLua::Extensions::Hash
end

class Array
  include ToLua::Extensions::Array
end

class String
  include ToLua::Extensions::String
end

class NilClass
  include ToLua::Extensions::NilClass
end

class Numeric
  include ToLua::Extensions::ToString
end

class TrueClass
  include ToLua::Extensions::ToString
end

class FalseClass
  include ToLua::Extensions::ToString
end

class Object
  include ToLua::Extensions::Object
end
