# frozen_string_literal: true

module Dry
  module ElasticModel
    module Attributes
      def field(name, type, opts = {})
        type_definition = Types::TYPES.fetch(type.to_sym)

        type_options_klass = type_definition.meta[:type_options]

        options = if type_options_klass
                    type_options_klass.new(opts).to_h
                  else
                    opts
                  end

        default_opts = type_definition.meta[:opts] || {}
        attribute(name,
                  type_definition.meta(opts: default_opts.merge(options.to_h)))
      end

      def range(name, type, opts = {})
        complex_type_definition(
          name: name, type: type, master_type: Types::Range, opts: opts
        )
      end

      def list(name, type, opts = {})
        complex_type_definition(
          name: name, type: type, master_type: Types::Array, opts: opts
        )
      end

      private

      def complex_type_definition(name:, type:, master_type:, opts:)
        member = Types::RANGE_TYPES.fetch(type.to_sym)

        type_definition = master_type.(member)

        default_opts = type_definition.meta[:opts] || {}
        attribute(name, type_definition.meta(opts: default_opts.merge(opts)))
      end
    end
  end
end
