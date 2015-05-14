require 'spec_helper'

describe ToLua::Helpers do
  describe '#encode_string' do
    it 'leaves printable characters' do
      expect(ToLua::Helpers.encode_string('abcdeČĘėŲŪŠ')).to eq('abcdeČĘėŲŪŠ')
    end

    it 'uses LUA c-style character escapes' do
      expect(ToLua::Helpers.encode_string("\a\b\f\n\r\t\v\7")).to eq('\\a\\b\\f\\n\\r\\t\\v\\a')
    end

    it 'escapes backslashes' do
      expect(ToLua::Helpers.encode_string("\\test\\\\")).to eq('\\\\test\\\\\\\\')
    end

    it 'escapes quotes' do
      expect(ToLua::Helpers.encode_string("\'\"")).to eq('\\\'\\"')
    end

    it 'escapes square brackets' do
      expect(ToLua::Helpers.encode_string("[]][")).to eq('\\[\\]\\]\\[')
    end

    it 'escapes unprintable characters' do
      expect(ToLua::Helpers.encode_string("\x00")).to eq('\\0')
    end

    it 'escapes a string with various symbols' do
      expect(ToLua::Helpers.encode_string("ab\nc[d''e\fČĘ\\\"]\x00ėŲ\rŪŠ")).to eq('ab\\nc\\[d\\\'\\\'e\\fČĘ\\\\\\"\\]\\0ėŲ\\rŪŠ')
    end
  end
end
