require_relative 'to_lua/generator'

class Hash
  include ToLua::Generator::GeneratorMethods::Hash
end

class Array
  include ToLua::Generator::GeneratorMethods::Array
end

class String
  include ToLua::Generator::GeneratorMethods::String
end

class NilClass
  include ToLua::Generator::GeneratorMethods::NilClass
end

class Numeric
  include ToLua::Generator::GeneratorMethods::ToString
end

class TrueClass
  include ToLua::Generator::GeneratorMethods::ToString
end

class FalseClass
  include ToLua::Generator::GeneratorMethods::ToString
end

class Object
  include ToLua::Generator::GeneratorMethods::Object
end
