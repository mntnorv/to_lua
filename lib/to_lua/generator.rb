require_relative 'helpers'

module ToLua
  module Generator
    class State
      attr_accessor :depth, :indent

      def self.from_state(opts)
        case
        when self === opts
          opts
        when opts.respond_to?(:to_hash)
          new(opts.to_hash)
        when opts.respond_to?(:to_h)
          new(opts.to_h)
        else
          new
        end
      end

      def initialize(opts = {})
        @pretty = false
        @depth  = 0
        @indent = '  '
        configure(opts)
      end

      def configure(opts)
        @pretty = opts[:pretty] if opts.key?(:pretty)
        @indent = opts[:indent] if opts.key?(:indent)
      end

      def pretty?
        @pretty
      end

      def to_h
        {
          pretty: @pretty,
          indent: @indent,
          depth:  @depth
        }
      end

      def ==(other)
        if other.is_a? State
          self.to_h == other.to_h
        else
          false
        end
      end
    end

    module GeneratorMethods
      module Hash
        def to_lua(state = nil)
          state = State.from_state(state)
          depth = state.depth += 1

          fields = []

          self.each do |key, value|
            field  =  ''
            field  << state.indent * state.depth if state.pretty?

            key_str = key.to_s
            if Helpers.valid_identifier?(key_str)
              field << key_str
            else
              field << '['
              field << key_str.to_lua
              field << ']'
            end

            field  << ' ' if state.pretty?
            field  << '='
            field  << ' ' if state.pretty?
            field  << value.to_lua(state)
            fields << field
          end

          depth = state.depth -= 1

          join_str = state.pretty? ? ",\n" : ','

          result =  '{'
          result << "\n" if state.pretty?
          result << fields.join(join_str)
          result << "\n" if state.pretty?
          result << state.indent * depth if state.pretty?
          result << '}'
          result
        end
      end

      module Array
        def to_lua(state = nil)
          state = State.from_state(state)
          depth = state.depth += 1

          fields = []

          self.each do |value|
            field  =  ''
            field  << state.indent * state.depth if state.pretty?
            field  << value.to_lua(state)
            fields << field
          end

          depth = state.depth -= 1

          join_str = state.pretty? ? ",\n" : ','

          result =  '{'
          result << "\n" if state.pretty?
          result << fields.join(join_str)
          result << "\n" if state.pretty?
          result << state.indent * depth if state.pretty?
          result << '}'
          result
        end
      end

      module String
        def to_lua(*)
          '"' + ToLua::Helpers.encode_string(self) + '"'
        end
      end

      module NilClass
        def to_lua(*)
          'nil'
        end
      end

      module ToString
        def to_lua(*)
          self.to_s
        end
      end

      module Object
        def to_lua(state = nil)
          if self.respond_to? :as_lua
            self.as_lua.to_lua(state)
          else
            self.to_s.to_lua(state)
          end
        end
      end
    end
  end
end
