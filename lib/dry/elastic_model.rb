# frozen_string_literal: true

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
      autoload :Base, "dry/elastic_model/type_options/base"
      autoload :Binary, "dry/elastic_model/type_options/binary"
      autoload :Boolean, "dry/elastic_model/type_options/boolean"
      autoload :Date, "dry/elastic_model/type_options/date"
      autoload :IP, "dry/elastic_model/type_options/ip"
      autoload :Keyword, "dry/elastic_model/type_options/keyword"
      autoload :Numeric, "dry/elastic_model/type_options/numeric"
      autoload :Object, "dry/elastic_model/type_options/object"
      autoload :Range, "dry/elastic_model/type_options/range"
      autoload :ScaledFloat, "dry/elastic_model/type_options/scaled_float"
      autoload :StringType, "dry/elastic_model/type_options/string_type"
      autoload :Text, "dry/elastic_model/type_options/text"
    end
  end
end
