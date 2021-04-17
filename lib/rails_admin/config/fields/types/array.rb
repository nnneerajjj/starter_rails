# frozen_string_literal: true

module RailsAdmin
  module Config
    module Fields
      module Types
        class Array < RailsAdmin::Config::Fields::Types::String
          SEPARATOR = ','

          RailsAdmin::Config::Fields::Types.register(:array, self)

          register_instance_option :formatted_value do
            value&.join(SEPARATOR + ' ')
          end

          def generic_help
            super + 'Use a comma to separate values.'
          end

          def parse_value(value)
            value.split(SEPARATOR).map(&:strip)
          end

          def parse_input(params)
            params[name] = parse_value(params[name]) if params[name].is_a?(::String)
          end
        end
      end
    end
  end
end
