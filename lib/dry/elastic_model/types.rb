# frozen_string_literal: true

require "dry-struct"
require "resolv"

module Dry
  module ElasticModel
    module Types
      include Dry::Types()

      # rubocop:disable Metrics/LineLength
      # String datatypes
      Text = (Types::Strict::String | Types::Strict::Nil).optional.meta(es_name: "text",
                                        type_options: TypeOptions::Text,
                                        opts: { index: "not_analyzed" })
      Keyword = (Types::Strict::String | Types::Strict::Symbol).optional.
                meta(type_options: TypeOptions::Keyword, es_name: "keyword")

      # Binary datatype
      # TODO: Verify if correct Base64
      Binary = Types::Strict::String.optional.
               meta(
                 es_name: "binary",
                 type_options: TypeOptions::Binary
               )

      # Date datatype
      Date = (
        Types::Strict::Date |
        Types::JSON::Date |
        Types.Value("now")
      ).optional.meta(es_name: "date", type_options: TypeOptions::Date)

      MAX_UNIX_TIME = 2147468400000 # 2038-01-19
      DateTime = (
        Types::Strict::Time |
        Types::Strict::DateTime |
        Types::JSON::DateTime |
        Types::Integer.constrained(gteq: 0, lteq:  MAX_UNIX_TIME) |
        Types.Value("now")
      ).optional.meta(es_name: "date", type_options: TypeOptions::Date)

      # Numeric datatypes
      LONG_LIMIT = 2**63
      INTEGER_LIMIT = 2**31
      SHORT_LIMIT = 2**15
      BYTE_LIMIT = 2**8

      Long = Types::Strict::Integer.optional.
             constrained(gteq: -LONG_LIMIT, lteq: LONG_LIMIT - 1).
             meta(type_options: TypeOptions::Numeric, es_name: "long")

      Integer = Types::Strict::Integer.optional.
                constrained(gteq: -INTEGER_LIMIT, lteq: INTEGER_LIMIT - 1).
                meta(type_options: TypeOptions::Numeric, es_name: "integer")

      Short = Types::Strict::Integer.optional.
              constrained(gteq: -SHORT_LIMIT, lteq: SHORT_LIMIT - 1).
              meta(type_options: TypeOptions::Numeric, es_name: "short")

      Byte = Types::Strict::Integer.optional.
             constrained(gteq: -BYTE_LIMIT, lteq: BYTE_LIMIT - 1).
             meta(type_options: TypeOptions::Numeric, es_name: "byte")

      Double = (Types::Strict::Integer | Types::Strict::Float).optional.
               meta(es_name: "double")
      Float = (Types::Strict::Integer | Types::Strict::Float).optional.
              meta(type_options: TypeOptions::Numeric, es_name: "float")

      HalfFloat = (Types::Strict::Integer | Types::Strict::Float).optional.
                  meta(type_options: TypeOptions::Numeric, es_name: "half_float")

      ScaledFloat = (Types::Strict::Integer | Types::Strict::Float).optional.
                    meta(type_options: TypeOptions::ScaledFloat,
                         es_name: "scaled_float")

      # Boolean datatype
      Boolean = (Types::Strict::Bool | Types.Value("true") | Types.Value("false")).optional.
                meta(es_name: "boolean", type_options: TypeOptions::Boolean)

      # IP datatype
      IP = (
        Types::Strict::String.constrained(format: Resolv::IPv4::Regex) |
        Types::Strict::String.constrained(format: Resolv::IPv6::Regex)
      ).optional.meta(es_name: "ip", type_options: TypeOptions::IP)

      Array = lambda do |type|
        Types::Strict::Array.of(type).meta(es_name: type.meta[:es_name])
      end

      Range = lambda do |type|
        Types::Strict::Hash.schema(
          gte: type.optional.default(nil),
          gt: type.optional.default(nil),
          lte: type.optional.default(nil),
          lt: type.optional.default(nil)
        ).strict.meta(es_name: "#{type.meta[:es_name]}_range",
                      type_options: TypeOptions::Range)
      end

      ObjectType = Types::Strict::Hash.optional.meta(es_name: "object",
                                                     type_options: TypeOptions::Object)

      TYPES = {
        text: Text,
        binary: Binary,
        keyword: Keyword,
        date: Date,
        datetime: DateTime,
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
      }.freeze

      RANGE_KEYS = %i(integer float long double date).freeze
      RANGE_TYPES = TYPES.select { |k, _v| RANGE_KEYS.include?(k) }
      # rubocop:enable Metrics/LineLength
    end
  end
end
