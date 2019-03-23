module Dry
  module ElasticModel
    module Schema
      include Types
      extend self

      def mapping
        {
          name.downcase.to_sym => {
            properties: self.schema.inject({}) do |h, (attr, definition)|
              opts = definition.meta.fetch(:opts, {})
              h.merge(
                attr => { type: definition.meta.fetch(:es_name) }.merge(opts)
              )
            end
          }
        }
      end

      # @param definition [Dry::Types::Definition]
      def parse_definition(definition)
        definition.meta[:es_name]
      end
    end
  end
end
