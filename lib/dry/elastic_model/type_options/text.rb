# frozen_string_literal: true

module Dry
  module ElasticModel
    module TypeOptions
      class Text < StringType
        # rubocop:disable Metrics/LineLength
        attribute :analyzer, Types::String.meta(omittable: true)
        attribute :fielddata, Types::Bool.meta(omittable: true)
        attribute :fielddata_frequency_filter, Types::String.meta(omittable: true)
        attribute :position_increment_gap, Types::Integer.meta(omittable: true)
        attribute :search_analyzer, Types::String.meta(omittable: true)
        attribute :search_quote_analyzer, Types::String.meta(omittable: true)
        attribute :term_vector, Types::Bool.meta(omittable: true)
        # rubocop:enable Metrics/LineLength

        def to_h
          attributes
        end
      end
    end
  end
end
