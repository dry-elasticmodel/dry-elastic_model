require "pry"
module Dry
  module ElasticModel
    module Attributes
      def field(name, type)
        attribute(name, Types::TYPES.fetch(type.to_sym))
      end
    end
  end
end
