require "dry/elastic_model/version"

module Dry
  module ElasticModel
    class Error < StandardError; end

    autoload :Attributes, "dry/elastic_model/attributes"
    autoload :Base, "dry/elastic_model/base"
    autoload :Types, "dry/elastic_model/types"
    autoload :Schema, "dry/elastic_model/schema"
  end
end
