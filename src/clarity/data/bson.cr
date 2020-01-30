require "mongo/bson"

module Clarity

  def self.from_bson(bson : BSON)
    Gnosis.debug("from_bson", "Clarity")
    Data.new bson.decode
  end

  class Data #de < Hash(String, Value)

    def initialize(bson : Hash(String, BSON::Field) | Array(BSON::Field))
      Gnosis.debug typeof(bson)
      nil
    end

    def initialize(bson : Hash(String, BSON::Field))
      Gnosis.debug("initialize Hash(String, BSON::Field)on")
      @value.merge!(clean_bson_hash(bson))
    end

    def initialize(bson : Array(BSON::Field))
      Rows.new clean_bson_array(bson)
    end

    def to_bson
      return @value.to_bson
    end

    def clean_bson(bson)

    end

    private def clean_bson_hash(hash_of_any : Hash(String, BSON::Field)) : Data
      clean = Data.new
      hash_of_any.each { |key,value|
        clean[key] = clean_bson_any(value)
      }
      clean
    end

    private def clean_bson_array(array_of_any : Array(BSON::Field)) : Array(Data)
      array_of_any.map { |value|
        clean_bson_any(value)
      }
    end

    private def clean_bson_any(value) : Data
      if value.as_h?
        clean_hash(value.as_h)
      elsif value.as_a?
        clean_array(value.as_a)
      elsif value.as_s?
        value.as_s
      elsif value.as_i64?
        value.as_i64
      elsif value.as_bool?
        value.as_bool
      elsif value.as_f?
        value.as_f
      else
        value.as_nil
      end
    end

  end
end
