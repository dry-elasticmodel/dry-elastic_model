# frozen_string_literal: true

module Dry
  module ElasticModel
    module TypeOptions
      class Object < Base
        attribute :dynamic, Types::Bool.meta(omittable: true)
        attribute :enabled, Types::Bool.meta(omittable: true)
        attribute :include_in_all, Types::Bool.meta(omittable: true)
        attribute :properties, Types::Hash.meta(omittable: true)
      end
    end
  end
end
