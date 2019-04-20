# frozen_string_literal: true

module Dry
  module ElasticModel
    module TypeOptions
      class Numeric < Dry::Struct
        input input.strict

        attribute :coerce, Types::Bool.meta(omittable: true)
        attribute :boost, Types::Float.meta(omittable: true)
        attribute :doc_values, Types::Bool.meta(omittable: true)
        attribute :ignore_malformed, Types::Bool.meta(omittable: true)
        attribute :include_in_all, Types::Bool.meta(omittable: true)
        attribute :index, Types::Bool.meta(omittable: true)
        attribute :null_value, Types::Bool.meta(omittable: true)
        attribute :store, Types::Bool.meta(omittable: true)

        def to_h
          attributes
        end
      end
    end
  end
end
