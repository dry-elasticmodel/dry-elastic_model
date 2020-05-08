# frozen_string_literal: true

module Dry
  module ElasticModel
    module Attributes
      def field(name, type, opts = {})
        allow_missing = opts.delete(:allow_missing)
        type_definition = Types::TYPES.fetch(type.to_sym)

        type_options_klass = type_definition.meta[:type_options]

        options = if type_options_klass
                    type_options_klass.new(opts).to_h
                  else
                    opts
                  end

        default_opts = type_definition.meta[:opts] || {}
        define_attribute(
          name,
          type_definition.meta(opts: default_opts.merge(options.to_h)),
          allow_missing: allow_missing
        )
      end

      def range(name, type, opts = {})
        allow_missing = allow_missing
        member = Types::RANGE_TYPES.fetch(type.to_sym)

        type_definition = Types::Range.call(member)

        default_opts = type_definition.meta[:opts] || {}
        define_attribute(
          name,
          type_definition.meta(opts: default_opts.merge(opts)),
          allow_missing: opts[:allow_missing]
        )
      end

      def list(name, type, opts = {})
        allow_missing = opts.delete(:allow_missing)
        member = Types::TYPES.fetch(type.to_sym)

        type_definition = Types::Array.call(member)

        default_opts = type_definition.meta[:opts] || {}
        define_attribute(
          name,
          type_definition.meta(opts: default_opts.merge(opts)),
          allow_missing: allow_missing
        )
      end

      private

      def define_attribute(name, type_definition, allow_missing:)
        public_send(
          attr_definition_method(allow_missing),
          name,
          type_definition
        )
      end

      def attr_definition_method(allow_missing)
        allow_missing = false if allow_missing.nil?
        allow_missing ? :attribute? : :attribute
      end
    end
  end
end
