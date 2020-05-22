# frozen_string_literal: true

require "spec_helper"

RSpec.describe Dry::ElasticModel::Types do
  shared_examples_for "type" do |expected_type|
    it "has #{expected_type} es type" do
      expect(type.meta[:es_name]).to eq(expected_type)
    end
  end

  shared_examples_for "null allowed" do
    it "accepts nil value if explicit" do
      expect(type[nil]).to eq(nil)
    end
  end

  shared_examples_for "null not allowed" do
    it "does not accept nil value" do
      expect { type[nil] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "text" do
    subject(:type) { described_class::Text }

    include_examples "type", "text"
    include_examples "null allowed"

    it "accepts string as value" do
      expect { type["test"] }.not_to raise_error
    end

    it "does not coerce other types" do
      expect { type[3] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "keyword" do
    subject(:type) { described_class::Keyword }

    include_examples "type", "keyword"
    include_examples "null allowed"

    it "accepts keyword as value" do
      expect { type[:test] }.not_to raise_error
    end

    it "accepts strings" do
      expect { type["test"] }.not_to raise_error
    end

    it "does not coerce other types" do
      expect { type[3] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "binary" do
    subject(:type) { described_class::Binary }

    include_examples "type", "binary"
    include_examples "null allowed"

    it "accepts string as value" do
      expect { type["test"] }.not_to raise_error
    end

    it "does not coerce other types" do
      expect { type[3] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "datetime" do
    subject(:type) { described_class::DateTime }

    include_examples "type", "date"
    include_examples "null allowed"

    it "accepts 'now' string" do
      expect { type["now"] }.not_to raise_error
    end

    it "accepts date strings and parses them" do
      str = "2019-11-26"
      expect { type[str] }.not_to raise_error
      expect(type[str]).to eq(Date.parse(str))
    end

    it "does not accept date" do
      expect { type[Date.today] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "accepts datetime" do
      now = DateTime.now
      expect { type[now] }.not_to raise_error
      expect(type[now]).to eq(now)
    end

    it "accepts time" do
      now = Time.now
      expect { type[now] }.not_to raise_error
      expect(type[now]).to eq(now)
    end

    it "does not accept any other string" do
      expect { type["test"] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "accepts UNIX epoch integers" do
      expect { type[-1] }.to raise_error(Dry::Types::ConstraintError)
      expect { type[0] }.not_to raise_error
      expect(type[0]).to eq(0)
      expect { type[2147468400000] }.not_to raise_error
      expect { type[2147468400001] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "date" do
    subject(:type) { described_class::Date }

    include_examples "type", "date"
    include_examples "null allowed"

    it "accepts 'now' string" do
      expect { type["now"] }.not_to raise_error
    end

    it "accepts date strings and parses them" do
      str = "2019-11-26"
      expect { type[str] }.not_to raise_error
      expect(type[str]).to eq(DateTime.parse(str))
    end

    it "accepts date" do
      expect { type[Date.today] }.not_to raise_error
      expect(type[Date.today]).to eq(Date.today)
    end

    it "accepts datetime" do
      now = DateTime.now
      expect { type[now] }.not_to raise_error
      expect(type[now]).to eq(now)
    end

    it "does not accept time" do
      now = Time.now
      expect { type[now] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept any other string" do
      expect { type["test"] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept any number" do
      expect { type[1] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "long" do
    subject(:type) { described_class::Long }

    include_examples "type", "long"
    include_examples "null allowed"

    it "accepts number" do
      expect { type[1] }.not_to raise_error
    end

    it "does not accept numbers beyond upper limit (2**63-1)" do
      expect { type[2**63 - 1] }.not_to raise_error
      expect { type[2**63] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept numbers beyond lower limit (-2**63)" do
      expect { type[-2**63] }.not_to raise_error
      expect { type[-2**63 - 1] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept string" do
      expect { type["test"] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept number string" do
      expect { type["10"] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "integer" do
    subject(:type) { described_class::Integer }

    include_examples "type", "integer"
    include_examples "null allowed"

    it "accepts number" do
      expect { type[1] }.not_to raise_error
    end

    it "does not accept numbers beyond upper limit (2**31-1)" do
      expect { type[2**31 - 1] }.not_to raise_error
      expect { type[2**31] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept numbers beyond lower limit (-2**31)" do
      expect { type[-2**31] }.not_to raise_error
      expect { type[-2**31 - 1] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept string" do
      expect { type["test"] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept number string" do
      expect { type["10"] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "short" do
    subject(:type) { described_class::Short }

    include_examples "type", "short"
    include_examples "null allowed"

    it "accepts number" do
      expect { type[1] }.not_to raise_error
    end

    it "does not accept numbers beyond upper limit (2**15-1)" do
      expect { type[2**15 - 1] }.not_to raise_error
      expect { type[2**15] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept numbers beyond lower limit (-2**15)" do
      expect { type[-2**15] }.not_to raise_error
      expect { type[-2**15 - 1] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept string" do
      expect { type["test"] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept number string" do
      expect { type["10"] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "byte" do
    subject(:type) { described_class::Byte }

    include_examples "type", "byte"
    include_examples "null allowed"

    it "accepts integer number" do
      expect { type[1] }.not_to raise_error
    end

    it "does not accept numbers beyond upper limit (2**8-1)" do
      expect { type[2**8 - 1] }.not_to raise_error
      expect { type[2**8] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept numbers beyond lower limit (-2**8)" do
      expect { type[-2**8] }.not_to raise_error
      expect { type[-2**8 - 1] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept floating point number" do
      expect { type[1.1] }.to raise_error(Dry::Types::ConstraintError)
    end
    it "does not accept string" do
      expect { type["test"] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept number string" do
      expect { type["10"] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  {
    double: described_class::Double,
    float: described_class::Float,
    half_float: described_class::HalfFloat,
    scaled_float: described_class::ScaledFloat
  }.each do |es_type_name, type_class|
    describe es_type_name.to_s do
      subject(:type) { type_class }

      include_examples "type", es_type_name.to_s
      include_examples "null allowed"

      it "accepts integer number" do
        expect { type[1] }.not_to raise_error
      end

      it "does accepts floating point number" do
        expect { type[1.1] }.not_to raise_error
      end

      it "does not accept string" do
        expect { type["test"] }.to raise_error(Dry::Types::ConstraintError)
      end

      it "does not accept number string" do
        expect { type["10"] }.to raise_error(Dry::Types::ConstraintError)
      end
    end
  end

  describe "boolean" do
    subject(:type) { described_class::Boolean }

    include_examples "type", "boolean"
    include_examples "null allowed"

    it "accepts true value" do
      expect { type[true] }.not_to raise_error
    end

    it "accepts false value" do
      expect { type[false] }.not_to raise_error
    end

    it "accepts 'false' value" do
      expect { type["false"] }.not_to raise_error
    end

    it "accepts 'true' value" do
      expect { type["true"] }.not_to raise_error
    end

    it "does not accept numeric values" do
      expect { type[0] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept other string values" do
      expect { type["test"] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "ip" do
    subject(:type) { described_class::IP }

    include_examples "type", "ip"
    include_examples "null allowed"

    it "accepts IPv4" do
      [
        "0.0.0.0",
        "1.0.0.126",
        "1.1.1.1",
        "127.0.0.1",
        "255.255.255.255"
      ].each do |ip|
        expect { type[ip] }.not_to raise_error
      end
    end

    it "accepts IPv6" do
      [
        "0:0:0:0:0:0:0:1",
        "::1",
        "0:0:0:0:0:0:0:0",
        "::",
        "2001:0db8:85a3:0000:0000:8a2e:0370:7334",
        "2001:db8:85a3:0:0:8a2e:370:7334",
        "2001:db8:85a3::8a2e:370:7334"
      ].each do |ip|
        expect { type[ip] }.not_to raise_error
      end
    end

    it "does not accept numeric values" do
      expect { type[0] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept other string values" do
      expect { type["test"] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "array" do
    context "when text type" do
      subject(:type) { described_class::Array.call(described_class::Text) }

      include_examples "type", "text"
      include_examples "null not allowed"

      it "accepts empty array" do
        expect { type[[]] }.not_to raise_error
      end

      it "accepts strings in a list" do
        expect { type[%w(a b c)] }.not_to raise_error
      end

      it "accepts nil in a list" do
        expect(type[["a", nil]]).to eq(["a", nil])
      end

      it "does not accept symbols in a list" do
        expect { type[[:a, "b", "c"]] }.to raise_error(Dry::Types::ConstraintError)
      end

      it "does not accept integers in a list" do
        expect { type[[1, "b", "c"]] }.to raise_error(Dry::Types::ConstraintError)
      end
    end

    context "when number type" do
      subject(:type) { described_class::Array.call(described_class::Integer) }

      include_examples "type", "integer"
      include_examples "null not allowed"

      it "accepts empty array" do
        expect { type[[]] }.not_to raise_error
      end

      it "accepts integers in a list" do
        expect { type[[1, 2, 3]] }.not_to raise_error
      end

      it "accept nil in a list" do
        expect(type[[1, nil]]).to eq([1, nil])
      end

      it "does not accept symbols in a list" do
        expect { type[[:a, 2, 3]] }.to raise_error(Dry::Types::ConstraintError)
      end

      it "does not accept strings in a list" do
        expect { type[["1", 2, 3]] }.to raise_error(Dry::Types::ConstraintError)
      end
    end
  end

  describe "range" do
    context "when IP type" do
      subject(:type) { described_class::Range.call(described_class::IP) }

      include_examples "type", "ip_range"
      include_examples "null not allowed"

      it "accepts hash with gt, gte, lt, lte values" do
        expect do
          type[{ lt: "127.0.0.10", gte: "127.0.0.1" }]
        end.not_to raise_error
      end
    end

    context "when number type" do
      subject(:type) { described_class::Range.call(described_class::Integer) }

      include_examples "type", "integer_range"
      include_examples "null not allowed"

      it "accepts empty hash" do
        expect { type[{}] }.not_to raise_error
      end

      it "accepts hash with gt, gte, lt, lte values" do
        expect do
          type[{ lt: 3, lte: 3, gt: 10, gte: 20 }]
        end.not_to raise_error
      end

      it "does not accept values of other type with correct key" do
        expect do
          type[{ lt: "3" }]
        end.to raise_error(Dry::Types::SchemaError)
      end

      it "does not accept if hash has other keys" do
        expect do
          type[{ foo: 1 }]
        end.to raise_error(Dry::Types::UnknownKeysError)
      end

      it "does not accept a list" do
        expect { type[[]] }.to raise_error(Dry::Types::ConstraintError)
      end

      it "does not accept symbols in a list" do
        expect { type["test"] }.to raise_error(Dry::Types::ConstraintError)
      end
    end
  end

  describe "object" do
    subject(:type) { described_class::ObjectType }

    include_examples "type", "object"
    include_examples "null allowed"

    it "accepts objects" do
      expect { type[{}] }.not_to raise_error
    end

    it "accepts nested objects" do
      expect { type[{ foo: :bar, baz: { bar: :foo } }] }.not_to raise_error
    end

    it "does not accept strings" do
      expect { type["test"] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept numbers" do
      expect { type[3] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept booleans" do
      expect { type[true] }.to raise_error(Dry::Types::ConstraintError)
    end
  end
end
