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
  
  describe '#valid_identifier_characters?' do
    it 'does not allow a number to be the first character' do
      expect(ToLua::Helpers.valid_identifier_characters?('1_invalid')).to be false
    end
    
    it 'allows latin letters, numbers and underscores' do
      expect(ToLua::Helpers.valid_identifier_characters?('_Valid_Identifier_1')).to be true
    end
    
    it 'does not allow any other characters' do
      expect(ToLua::Helpers.valid_identifier_characters?('_Invalid-Identifier-1')).to be false
    end
  end
  
  describe '#reserved_keyword?' do
    it 'returns true if the identifier is a reserved keyword in lua' do
      expect(ToLua::Helpers.reserved_keyword?('true')).to be true
    end
    
    it 'returns false if the identifier is not a reserved keyword in lua' do
      expect(ToLua::Helpers.reserved_keyword?('class')).to be false
    end
  end
  
  describe '#valid_identifier?' do
    it 'returns true if the identifier both has valid characters and is not a reserved keyword' do
      allow(ToLua::Helpers).to receive(:valid_identifier_characters?).and_return(true)
      allow(ToLua::Helpers).to receive(:reserved_keyword?).and_return(false)

      expect(ToLua::Helpers.valid_identifier?('test_identifier')).to be true
    end
    
    it 'returns false if the identifier has invalid characters' do
      allow(ToLua::Helpers).to receive(:valid_identifier_characters?).and_return(false)
      allow(ToLua::Helpers).to receive(:reserved_keyword?).and_return(false)

      expect(ToLua::Helpers.valid_identifier?('test_identifier')).to be false
    end
    
    it 'returns false if the identifier is a reserved keyword' do
      allow(ToLua::Helpers).to receive(:valid_identifier_characters?).and_return(true)
      allow(ToLua::Helpers).to receive(:reserved_keyword?).and_return(true)

      expect(ToLua::Helpers.valid_identifier?('test_identifier')).to be false
    end
  end
end
