require "spec_helper"

RSpec.describe Dry::ElasticModel::Base do
  class Foo < described_class
    field :text_field, :text
    field :keyword_field, :keyword, index: false
    field :date_field, :date
    field :long_field, :long
    field :double_field, :double
    field :boolean_field, :boolean
    field :ip_field, :ip
    list  :list_text_field, :text
    range :range_long_field, :long
  end

  describe "mapping" do
    let(:expected_mapping) do
      {
        foo: {
          properties: {
            text_field: {
              type: "text",
              index: "not_analyzed"
            },
            keyword_field: {
              type: "keyword",
              index: false
            },
            date_field: {
              type: "date",
              format: "strict_date_optional_time||epoch_millis"
            },
            long_field: {
              type: "long"
            },
            double_field: {
              type: "double"
            },
            boolean_field: {
              type: "boolean"
            },
            ip_field: {
              type: "ip"
            },
            list_text_field: {
              type: "text"
            },
            range_long_field: {
              type: "long_range"
            }
          }
        }
      }
    end

    it "is valid" do
      expect(Foo.mapping).to eq(expected_mapping)
    end
  end

  describe "as_json" do
    it "returns instance of model" do
      model = Foo.new(
        text_field: "foo",
        keyword_field: :test,
        date_field: Date.today,
        long_field: 10,
        double_field: 1.0,
        boolean_field: true,
        ip_field: "127.0.0.1",
        list_text_field: ["a", "b", "c"],
        range_long_field: {
          gt: 0,
          lt: 10
        }
      )

      expect(model.as_json).to(
        eq(
          text_field: "foo",
          keyword_field: :test,
          date_field: Date.today,
          long_field: 10,
          double_field: 1.0,
          boolean_field: true,
          ip_field: "127.0.0.1",
          list_text_field: ["a", "b", "c"],
          range_long_field: {
            gt: 0,
            gte: nil,
            lt: 10,
            lte: nil
          }
        )
      )
    end
  end
end
