require 'spec_helper'

describe ToLua::Extensions do
  describe Hash do
    it 'correctly serializes an empty Hash' do
      expect({}.to_lua).to eq('{}')
    end

    it 'correctly serializes a simple Hash' do
      expect({key: 'value'}.to_lua).to eq('{["key"]="value"}')
    end

    it 'correctly serializes a Hash with multiple keys' do
      expect({two: 'second', one: 'first'}.to_lua).to eq('{["two"]="second",["one"]="first"}')
    end

    it 'calls to_lua on values' do
      object = 'string'
      expect(object).to receive(:to_lua) { '**serialized_lua**' }
      expect({key: object}.to_lua).to eq('{["key"]=**serialized_lua**}')
    end

    it 'calls to_s on keys' do
      expect({10 => 'value'}.to_lua).to eq('{["10"]="value"}')
    end
  end

  describe Array do
    it 'correctly serializes an empty Array' do
      expect([].to_lua).to eq('{}')
    end

    it 'correctly serializes a simple Array' do
      expect(['value'].to_lua).to eq('{"value"}')
    end

    it 'correctly serializes an Array with multiple values' do
      expect(['first', 2].to_lua).to eq('{"first",2}')
    end

    it 'calls to_lua on values' do
      object = 'string'
      expect(object).to receive(:to_lua) { '**serialized_lua**' }
      expect([object].to_lua).to eq('{**serialized_lua**}')
    end
  end

  describe String do
    it 'adds quotes' do
      expect('test'.to_lua).to eq('"test"')
    end

    it 'uses ToLua::Helpers.encode_string' do
      expect(ToLua::Helpers).to receive(:encode_string).with('test_str').and_call_original
      'test_str'.to_lua
    end
  end

  describe Numeric do
    it 'correctly serializes Fixnums' do
      expect(1.to_lua).to eq('1')
      expect(123456789.to_lua).to eq('123456789')
    end

    it 'correctly serializes Floats' do
      expect(1.1.to_lua).to eq('1.1')
      expect(12345.6789.to_lua).to eq('12345.6789')
    end
  end

  describe NilClass do
    it 'correctly serializes nil' do
      expect(nil.to_lua).to eq('nil')
    end
  end

  describe TrueClass do
    it 'correctly serializes true' do
      expect(true.to_lua).to eq('true')
    end
  end

  describe FalseClass do
    it 'correctly serializes false' do
      expect(false.to_lua).to eq('false')
    end
  end
end
