# frozen_string_literal: true

module Dry
  module ElasticModel
    module TypeOptions
      class Object < Base
        # rubocop:disable Metrics/LineLength
        attribute :dynamic, Types::Bool.meta(omittable: true)
        attribute :enabled, Types::Bool.meta(omittable: true)
        attribute :include_in_all, Types::Bool.meta(omittable: true)
        attribute :properties, Types::Hash.meta(omittable: true)
        # rubocop:enable Metrics/LineLength
      end
    end
  end
end
