module Clarity
  class Data #de < Hash(String, Value)

    def to_msgpack : String
      String.new(@value.to_msgpack)
    end

    def to_json

    end

    def to_bson

    end

  end
end