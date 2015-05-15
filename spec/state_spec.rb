require 'spec_helper'

describe ToLua::Generator::State do
  describe '#initialize' do
    it 'sets pretty to false by default' do
      expect(ToLua::Generator::State.new.pretty?).to eq(false)
    end

    it 'sets indent to two spaces by default' do
      expect(ToLua::Generator::State.new.indent).to eq('  ')
    end

    it 'sets pretty to the passed value' do
      expect(ToLua::Generator::State.new(pretty: true).pretty?).to eq(true)
    end

    it 'sets indent to the passed value' do
      expect(ToLua::Generator::State.new(indent: "\t").indent).to eq("\t")
    end
  end

  describe '.from_state' do
    it 'returns state if a state is passed' do
      state = ToLua::Generator::State.new
      expect(ToLua::Generator::State.from_state(state)).to be(state)
    end

    it 'creates a new state with to_hash if available' do
      obj = double('to_hash object')
      expect(obj).to receive(:to_hash).and_return({ to_hash: true }).at_least(:once)
      expect(ToLua::Generator::State).to receive(:new).with(obj.to_hash)
      ToLua::Generator::State.from_state(obj)
    end

    it 'creates a new state with to_h if available' do
      obj = double('to_h object')
      expect(obj).to receive(:to_h).and_return({ to_h: true }).at_least(:once)
      expect(ToLua::Generator::State).to receive(:new).with(obj.to_h)
      ToLua::Generator::State.from_state(obj)
    end

    it 'creates a default state otherwise' do
      expect(ToLua::Generator::State.from_state(123)).to eq(ToLua::Generator::State.new)
    end
  end
end
