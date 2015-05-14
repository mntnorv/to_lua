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
  end
end
