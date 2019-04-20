# frozen_string_literal: true

module Dry
  module ElasticModel
    module TypeOptions
      class Range < Base
        # rubocop:disable Metrics/LineLength
        attribute :coerce, Types::Bool.meta(omittable: true)
        attribute :boost, Types::Float.meta(omittable: true)
        attribute :include_in_all, Types::Bool.meta(omittable: true)
        attribute :index, Types::Bool.meta(omittable: true)
        attribute :store, Types::Bool.meta(omittable: true)
        # rubocop:enable Metrics/LineLength
      end
    end
  end
end
