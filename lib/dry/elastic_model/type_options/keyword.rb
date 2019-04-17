module Dry
  module ElasticModel
    module TypeOptions
      class Keyword < StringType
        attribute :doc_values, Types::Bool.meta(omittable: true)
        attribute :ignore_above, Types::Bool.meta(omittable: true)
        attribute :null_value, Types::Bool.meta(omittable: true)
        attribute :normalizer, Types::String.meta(omittable: true)

        def to_h
          attributes
        end
      end
    end
  end
end
