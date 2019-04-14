require "dry/elastic_model/version"
require "dry-struct"

module Dry
  module ElasticModel
    class Error < StandardError; end

    autoload :Attributes, "dry/elastic_model/attributes"
    autoload :Base, "dry/elastic_model/base"
    autoload :Types, "dry/elastic_model/types"
    autoload :Schema, "dry/elastic_model/schema"

    module TypeOptions
      autoload :Text, "dry/elastic_model/type_options/text"
      autoload :Numeric, "dry/elastic_model/type_options/numeric"
    end
  end
end
