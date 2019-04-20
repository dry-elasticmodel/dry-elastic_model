# frozen_string_literal: true

require "spec_helper"

RSpec.describe Dry::ElasticModel::TypeOptions do
  it "raises runtime error if option is unknown" do
    expect do
      class Foo < Dry::ElasticModel::Base
        field :bar, :text, foo: "bar"
      end
    end.to raise_error(Dry::Struct::Error, /unexpected keys/)
  end

  it "raises runtime error if option value is unknown" do
    expect do
      class Foo < Dry::ElasticModel::Base
        field :bar, :text, similarity: "good"
      end
    end.to raise_error(Dry::Struct::Error, /violates constraints/)
  end

  describe "scaled_float" do
    it "requires scaling factor option" do
      expect do
        class Foo < Dry::ElasticModel::Base
          field :float_field, :scaled_float
        end
      end.to raise_error(Dry::Struct::Error, /:scaling_factor is missing/)

      expect do
        class Bar < Dry::ElasticModel::Base
          field :float_field, :scaled_float, scaling_factor: 10
        end
      end.not_to raise_error
    end
  end
end
