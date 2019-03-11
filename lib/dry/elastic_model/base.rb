require "dry-struct"

module Dry
  module ElasticModel
    class Base < Dry::Struct
      extend Schema
      extend Attributes
    end
  end
end
