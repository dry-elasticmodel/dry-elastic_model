module Dry
  module ElasticModel
    module Types
      include Dry::Types.module

      # String datatypes
      Text = Types::String.meta(es_name: "text", opts: { index: "not_analyzed" })
      Keyword = Types::Symbol.meta(es_name: "keyword")

      # Binary datatype
      # TODO: Verify if correct Base64
      Binary = Types::String.meta(es_name: "binary")

      # Date datatype
      # TODO: Test strings
      Date = (Types::Date | Types.Value('now')).meta(es_name: "date", opts: { format: "strict_date_optional_time||epoch_millis" })

      # Numeric datatypes
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

      # Boolean datatype
      Boolean = (Types::Strict::Bool | Types.Value('true') | Types.Value('false')).meta(es_name: "boolean")

      # IP datatype
      IP = Types::String.
             constrained(format: /\A(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\z/i).
             meta(es_name: "ip")

      Array = ->(type) do
        Types::Strict::Array.of(type).meta(es_name: type.meta[:es_name])
      end

      Range = ->(type) do
        Types::Hash.schema(
          gte: type.optional.default(nil),
          gt: type.optional.default(nil),
          lte: type.optional.default(nil),
          lt: type.optional.default(nil)
        ).meta(es_name: "#{type.meta[:es_name]}_range")
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
        ip: IP
      }

      RANGE_KEYS = %i[integer float long double date]
      RANGE_TYPES = TYPES.select {|k, _v| RANGE_KEYS.include?(k) }
    end
  end
end
