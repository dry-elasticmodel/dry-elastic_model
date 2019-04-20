# frozen_string_literal: true

require "spec_helper"

RSpec.describe Dry::ElasticModel do
  it "has a version number" do
    expect(Dry::ElasticModel::VERSION).not_to be nil
  end
end
