require "spec_helper"

RSpec.describe Dry::ElasticModel::Types do
  shared_examples_for "type" do |expected_type|
    it "has #{expected_type} es type" do
      expect(type.meta[:es_name]).to eq(expected_type)
    end
  end

  describe "text" do
    subject(:type) { described_class::Text }

    include_examples "type", "text"

    it "accepts string as value" do
      expect { type["test"] }.not_to raise_error
    end

    it "does not coerce other types" do
      expect { type[3] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "keyeword" do
    subject(:type) { described_class::Keyword }

    include_examples "type", "keyword"

    it "accepts keyword as value" do
      expect { type[:test] }.not_to raise_error
    end

    it "does not accept string" do
      expect { type["test"] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not coerce other types" do
      expect { type[3] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "binary" do
    subject(:type) { described_class::Binary }

    include_examples "type", "binary"

    it "accepts string as value" do
      expect { type["test"] }.not_to raise_error
    end

    it "does not coerce other types" do
      expect { type[3] }.to raise_error(Dry::Types::ConstraintError)
    end
  end

  describe "date" do
    subject(:type) { described_class::Date }

    include_examples "type", "date"

    it "accepts 'now' string" do
      expect { type["now"] }.not_to raise_error
    end

    it "accepts date" do
      expect { type[Date.today] }.not_to raise_error
    end

    it "accepts datetime" do
      expect { type[DateTime.now] }.not_to raise_error
    end

    it "accepts time" do
      expect { type[Time.now] }.not_to raise_error
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

    it "accepts number" do
      expect { type[1] }.not_to raise_error
    end

    it "does not accept numbers beyond upper limit (2**63-1)" do
      expect { type[2**63-1] }.not_to raise_error
      expect { type[2**63] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept numbers beyond lower limit (-2**63)" do
      expect { type[-2**63] }.not_to raise_error
      expect { type[-2**63-1] }.to raise_error(Dry::Types::ConstraintError)
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

    it "accepts number" do
      expect { type[1] }.not_to raise_error
    end

    it "does not accept numbers beyond upper limit (2**31-1)" do
      expect { type[2**31-1] }.not_to raise_error
      expect { type[2**31] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept numbers beyond lower limit (-2**31)" do
      expect { type[-2**31] }.not_to raise_error
      expect { type[-2**31-1] }.to raise_error(Dry::Types::ConstraintError)
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

    it "accepts number" do
      expect { type[1] }.not_to raise_error
    end

    it "does not accept numbers beyond upper limit (2**15-1)" do
      expect { type[2**15-1] }.not_to raise_error
      expect { type[2**15] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept numbers beyond lower limit (-2**15)" do
      expect { type[-2**15] }.not_to raise_error
      expect { type[-2**15-1] }.to raise_error(Dry::Types::ConstraintError)
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

    it "accepts integer number" do
      expect { type[1] }.not_to raise_error
    end

    it "does not accept numbers beyond upper limit (2**8-1)" do
      expect { type[2**8-1] }.not_to raise_error
      expect { type[2**8] }.to raise_error(Dry::Types::ConstraintError)
    end

    it "does not accept numbers beyond lower limit (-2**8)" do
      expect { type[-2**8] }.not_to raise_error
      expect { type[-2**8-1] }.to raise_error(Dry::Types::ConstraintError)
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
      subject(:type) { described_class::Array.(described_class::Text) }

      include_examples "type", "text"

      it "accepts empty array" do
        expect { type[[]] }.not_to raise_error
      end

      it "accepts stings in a list" do
        expect { type[["a", "b", "c"]] }.not_to raise_error
      end

      it "does not accept nil" do
        expect { type[nil] }.to raise_error(Dry::Types::ConstraintError)
      end

      it "does not accept nil in a list" do
        expect { type[["a", nil]] }.to raise_error(Dry::Types::ConstraintError)
      end

      it "does not accept symbols in a list" do
        expect { type[[:a, "b", "c"]] }.to raise_error(Dry::Types::ConstraintError)
      end

      it "does not accept integers in a list" do
        expect { type[[1, "b", "c"]] }.to raise_error(Dry::Types::ConstraintError)
      end
    end

    context "when number type" do
      subject(:type) { described_class::Array.(described_class::Integer) }

      include_examples "type", "integer"

      it "accepts empty array" do
        expect { type[[]] }.not_to raise_error
      end

      it "accepts integers in a list" do
        expect { type[[1, 2, 3]] }.not_to raise_error
      end

      it "does not accept nil" do
        expect { type[nil] }.to raise_error(Dry::Types::ConstraintError)
      end

      it "does not accept nil in a list" do
        expect { type[[1, nil]] }.to raise_error(Dry::Types::ConstraintError)
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
  end

  describe "object" do
  end
end
