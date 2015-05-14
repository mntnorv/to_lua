require_relative 'helpers'

module ToLua
  module Extensions
    module Hash
      def to_lua
        fields = []

        self.each do |key, value|
          field  =  '['
          field  << key.to_s.to_lua
          field  << ']='
          field  << value.to_lua
          fields << field
        end

        '{' + fields.join(',') + '}'
      end
    end

    module Array
      def to_lua
        fields = []

        self.each do |value|
          fields << value.to_lua
        end

        '{' + fields.join(',') + '}'
      end
    end

    module String
      def to_lua
        '"' + ToLua::Helpers.encode_string(self) + '"'
      end
    end

    module NilClass
      def to_lua
        'nil'
      end
    end

    module ToString
      def to_lua
        self.to_s
      end
    end

    module Object
      def to_lua
        if self.respond_to? :as_lua
          self.as_lua.to_lua
        else
          self.to_s.to_lua
        end
      end
    end
  end
end
