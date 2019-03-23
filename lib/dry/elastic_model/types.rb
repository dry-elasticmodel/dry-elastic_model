module Dry
  module ElasticModel
    module Types
      include Dry::Types.module

      Text = Types::String.meta(es_name: "text", opts: { index: "not_analyzed" })
      Keyword = Types::Symbol.meta(es_name: "keyword")

      # TODO: Verify if correct Base64
      Binary = Types::String.meta(es_name: "binary")

      Date = Types::Date.meta(es_name: "date", opts: { format: "strict_date_optional_time||epoch_millis" })
      Long = Types::Integer.constrained(gteq: -2**63, lteq: 2**63-1).meta(es_name: "long")
      Integer = Types::Integer.constrained(gteq: -2**31, lteq: 2**31-1).meta(es_name: "integer")
      Short = Types::Integer.meta(es_name: "short").
                constrained(gteq: -32_768, lteq: 32_767)
      Byte = Types::Integer.meta(es_name: "byte").
               constrained(gteq: -128, lteq: 127)
      Double = Types::Float.meta(es_name: "double")
      Float = Types::Float.meta(es_name: "float")
      HalfFloat = Types::Float.meta(es_name: "half_flot")
      ScaledFloat = Types::Float.meta(es_name: "scaled_flot")
      Boolean = (Types::Strict::Bool | Types.Value('true') | Types.Value('false')).meta(es_name: "boolean")
      IP = Types::String.
             constrained(format: /\A(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\z/i).
             meta(es_name: "ip")

      class IntegerRange < Dry::Struct
        attribute :gte, Integer
        attribute :lte, Integer
      end

      TYPES = {
        text: Text,
        binary: Binary,
        keyword: Keyword,
        date: Date,
        long: Long,
        integer: Integer,
        short: Short,
        byte: Byte,
        double: Double,
        float: Float,
        half_float: HalfFloat,
        scaled_float: ScaledFloat,
        boolean: Boolean,
        integer_range: IntegerRange,
        ip: IP
      }
    end
  end
end
