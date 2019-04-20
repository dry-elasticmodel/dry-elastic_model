# frozen_string_literal: true

module Dry
  module ElasticModel
    module TypeOptions
      class ScaledFloat < Numeric
        input input.strict

        attribute :scaling_factor, Types::Integer

        def to_h
          attributes
        end
      end
    end
  end
end
