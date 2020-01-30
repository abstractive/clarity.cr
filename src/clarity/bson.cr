require "mongo/bson"

def BSON.from_msgpack(string : String)
  Clarity.dismantleHash(String, MessagePack::Type).from_msgpack(input)).to_bson
end
