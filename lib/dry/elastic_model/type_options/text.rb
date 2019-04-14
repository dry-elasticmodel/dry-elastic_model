module Dry
  module ElasticModel
    module TypeOptions
      class Text < Dry::Struct
        input input.strict

        attribute :analyzer, Types::String.meta(omittable: true)
        attribute :boost, Types::Float.meta(omittable: true)
        attribute :eager_global_ordinals, Types::Bool.meta(omittable: true)
        attribute :fielddata, Types::Bool.meta(omittable: true)
        attribute :fielddata_frequency_filter, Types::String.meta(omittable: true)
        attribute :fields, Types::Hash.meta(omittable: true)
        attribute :include_in_all, Types::Bool.meta(omittable: true)
        attribute :index, Types::Bool.meta(omittable: true)
        # TODO: Allow https://www.elastic.co/guide/en/elasticsearch/reference/5.6/index-options.html
        attribute :index_options, Types::Hash.meta(omittable: true)

        attribute :norms, Types::Bool.meta(omittable: true)
        attribute :position_increment_gap, Types::Integer.meta(omittable: true)
        attribute :store, Types::Bool.meta(omittable: true)
        attribute :search_analyzer, Types::String.meta(omittable: true)
        attribute :search_quote_analyzer, Types::String.meta(omittable: true)
        attribute :similarity, (Types::Value('BM25') | Types::Value('classic') | Types::Value('boolean')).meta(omittable: true)
        attribute :term_vector, Types::Bool.meta(omittable: true)

        def to_h
          attributes.compact
        end
      end
    end
  end
end
