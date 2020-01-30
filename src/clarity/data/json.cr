require "json"

module Clarity

  def self.from_json(string : String)
      Gnosis.debug("from_json", "Clarity")
    Data.new JSON.parse(string).as_h
  end

  class Data #de < Hash(String, Value)

    def initialize(hash : Hash(String, JSON::Any::Type))
      Gnosis.debug("initialize Hash(String, JSON::Any::Type)")
      #de initialize
      self.merge!(clean_json_hash(json))
    end
    
    def initialize(json : JSON::Any)
      Gnosis.debug("initialize JSON::Any")
      #de initialize
      self.merge!(clean_json_hash(json.as_h))
    end

    private def clean_json_hash(hash_of_any : Hash(String, JSON::Any)) : Data
      clean = Data.new
      hash_of_any.each { |key,value|
        clean[key] = clean_json_any(value)
      }
      clean
    end

    private def clean_json_array(array_of_any : Array(JSON::Any)) : Array(Data)
      array_of_any.map { |value|
        clean_json_any(value)
      }
    end

    private def clean_json_any(value) : Data
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
