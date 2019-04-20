# frozen_string_literal: true

module Dry
  module ElasticModel
    module TypeOptions
      class Binary < Base
        attribute :doc_values, Types::Bool.meta(omittable: true)
        attribute :store, Types::Bool.meta(omittable: true)
      end
    end
  end
end
