# frozen_string_literal: true

module Dry
  module ElasticModel
    module TypeOptions
      class Keyword < StringType
        attribute :doc_values, Types::Bool.meta(omittable: true)
        attribute :ignore_above, Types::Bool.meta(omittable: true)
        attribute :null_value, Types::Bool.meta(omittable: true)
        attribute :normalizer, Types::String.meta(omittable: true)
      end
    end
  end
end
