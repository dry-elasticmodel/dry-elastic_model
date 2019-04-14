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
end
