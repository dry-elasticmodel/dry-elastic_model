# frozen_string_literal: true

module Dry
  module ElasticModel
    VERSION = File.read(
      File.expand_path(File.join(File.dirname(__FILE__), "../../../VERSION"))
    ).strip.freeze
  end
end
