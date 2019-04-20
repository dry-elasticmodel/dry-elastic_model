# frozen_string_literal: true

require "dry-struct"

module Dry
  module ElasticModel
    class Base < Dry::Struct
      extend Schema
      extend Attributes

      def as_json(opts = {})
        if attributes.respond_to? :as_json
          attributes.as_json(opts)
        else
          attributes
        end
      end
    end
  end
end
