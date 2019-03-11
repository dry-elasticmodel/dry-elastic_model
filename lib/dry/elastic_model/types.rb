module Dry
  module ElasticModel
    module Types
      include Dry::Types.module

      Text = Types::String.meta(es_name: "text", opts: { index: "not_analyzed" })
      Keyword = Types::Symbol.meta(es_name: "keyword")
      Date = Types::Date.meta(es_name: "date", opts: { format: "strict_date_optional_time||epoch_millis" })
      Long = Types::Integer.meta(es_name: "long")
      Double = Types::Integer.meta(es_name: "double")
      Boolean = Types::Bool.meta(es_name: "boolean")
      IP = Types::String.constrained(format: /\A(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\z/i).meta(es_name: "ip")

      TYPES = {
        text: Text,
        keyword: Keyword,
        date: Date,
        long: Long,
        double: Double,
        boolean: Boolean,
        ip: IP
      }
    end
  end
end
