module ToLua
  class Helpers
    LUA_C_STYLE_ESCAPES = {
      "\a" => "\\a",
      "\b" => "\\b",
      "\f" => "\\f",
      "\n" => "\\n",
      "\r" => "\\r",
      "\t" => "\\t",
      "\v" => "\\v",
      "\\" => "\\\\",
      "\"" => "\\\"",
      "'"  => "\\'",
      "["  => "\\[",
      "]"  => "\\]"
    }.freeze
    
    LUA_RESERVED_KEYWORDS = %w(
      and break do else elseif end false for function if in local nil not or
      repeat return then true until while
    )

    def self.encode_string(string)
      encoded = []

      string.each_char do |char|
        if LUA_C_STYLE_ESCAPES[char]
          encoded << LUA_C_STYLE_ESCAPES[char]
        elsif char =~ /^[^[:print:]]$/
          char.each_byte do |byte|
            encoded << '\\'
            encoded << byte.to_s
          end
        else
          encoded << char
        end
      end

      encoded.join
    end
    
    def self.valid_identifier?(identifier)
      valid_identifier_characters?(identifier) && !reserved_keyword?(identifier)
    end

    def self.valid_identifier_characters?(identifier)
      !!(identifier =~ /^[_a-zA-Z][_a-zA-Z0-9]*$/)
    end

    def self.reserved_keyword?(identifier)
      LUA_RESERVED_KEYWORDS.include?(identifier)
    end
  end
end
