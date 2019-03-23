require "pry"
module Dry
  module ElasticModel
    module Attributes
      def field(name, type, opts = {})
        type_definition = Types::TYPES.fetch(type.to_sym)

        default_opts = type_definition.meta[:opts] || {}
        attribute(name, type_definition.meta(opts: default_opts.merge(opts)))
      end
    end
  end
end