# frozen_string_literal: true

require "spec_helper"

RSpec.describe Dry::ElasticModel::Attributes do
  it "requires all keys to be present by default" do
    expect do
      Class.new(Dry::ElasticModel::Base) do
        field :foo, :text
        field :bar, :text
      end.new(foo: "x")
    end.to raise_error(/:bar is missing in Hash input/)
  end

  it "accepts null values by default" do
    a = { foo: nil, bar: nil }
    v = Class.new(Dry::ElasticModel::Base) do
      field :foo, :text
      field :bar, :text
    end.new(a)

    expect(v.attributes).to eq(a)
  end

  it "allows defining missing keys" do
    v = Class.new(Dry::ElasticModel::Base) do
      field :foo, :text, allow_missing: true
      range :bar, :integer, allow_missing: true
      list :baz, :text, allow_missing: true
      field :zee, :text
    end.new(zee: "x")

    expect(v.attributes).to eq(zee: "x")
    expect(v.foo).to eq(nil)
  end
end
