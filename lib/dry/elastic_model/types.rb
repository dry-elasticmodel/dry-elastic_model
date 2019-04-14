require "dry-struct"
require "resolv"

module Dry
  module ElasticModel
    module Types
      include Dry::Types.module

      # String datatypes
      Text = Types::Strict::String.meta(es_name: "text",
                                        type_options: TypeOptions::Text,
                                        opts: { index: "not_analyzed" })
      Keyword = Types::Strict::Symbol.meta(type_options: TypeOptions::Keyword,
                                           es_name: "keyword")

      # Binary datatype
      # TODO: Verify if correct Base64
      Binary = Types::Strict::String.meta(es_name: "binary")

      # Date datatype
      # TODO: Test strings
      Date = (Types::Strict::Date | Types::Strict::Time | Types.Value('now')).meta(es_name: "date", opts: { format: "strict_date_optional_time||epoch_millis" })

      # Numeric datatypes
      LONG_LIMIT = 2**63
      INTEGER_LIMIT = 2**31
      SHORT_LIMIT = 2**15
      BYTE_LIMIT = 2**8

      Long = Types::Strict::Integer.
               constrained(gteq: -LONG_LIMIT, lteq: LONG_LIMIT-1).
               meta(type_options: TypeOptions::Numeric, es_name: "long")
      Integer = Types::Strict::Integer.
                  constrained(gteq: -INTEGER_LIMIT, lteq: INTEGER_LIMIT-1).
                  meta(type_options: TypeOptions::Numeric, es_name: "integer")
      Short = Types::Strict::Integer.
                constrained(gteq: -SHORT_LIMIT, lteq: SHORT_LIMIT-1).
                meta(type_options: TypeOptions::Numeric, es_name: "short")
      Byte = Types::Strict::Integer.
               constrained(gteq: -BYTE_LIMIT, lteq: BYTE_LIMIT-1).
               meta(type_options: TypeOptions::Numeric, es_name: "byte")
      Double = (Types::Strict::Integer | Types::Strict::Float).
                 meta(es_name: "double")
      Float = (Types::Strict::Integer | Types::Strict::Float).
                meta(type_options: TypeOptions::Numeric, es_name: "float")
      HalfFloat = (Types::Strict::Integer | Types::Strict::Float).
                    meta(type_options: TypeOptions::Numeric, es_name: "half_float")
      ScaledFloat = (Types::Strict::Integer | Types::Strict::Float).
                      meta(type_options: TypeOptions::ScaledFloat, es_name: "scaled_float")

      # Boolean datatype
      Boolean = (Types::Strict::Bool | Types.Value('true') | Types.Value('false')).
                  meta(es_name: "boolean")

      # IP datatype
      IP = (
        Types::Strict::String.constrained(format: Resolv::IPv4::Regex) |
        Types::Strict::String.constrained(format: Resolv::IPv6::Regex)
      ).meta(es_name: "ip")

      Array = ->(type) do
        Types::Strict::Array.of(type).meta(es_name: type.meta[:es_name])
      end

      Range = ->(type) do
        Types::Strict::Hash.schema(
          gte: type.optional.default(nil),
          gt: type.optional.default(nil),
          lte: type.optional.default(nil),
          lt: type.optional.default(nil)
        ).strict.meta(es_name: "#{type.meta[:es_name]}_range")
      end

      ObjectType = Types::Strict::Hash.meta(es_name: "object")

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
        ip: IP,
        object: ObjectType
      }

      RANGE_KEYS = %i[integer float long double date]
      RANGE_TYPES = TYPES.select {|k, _v| RANGE_KEYS.include?(k) }
    end
  end
end
