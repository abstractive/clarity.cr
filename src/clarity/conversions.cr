require "mongo/bson"
require "../clarity"

def BSON.from_msgpack(input : String)
  Clarity.dismantle Hash(String, MessagePack::Type).from_msgpack(input).to_bson
end

def Clarity.from_msgpack(input)
  dismantle Hash(String, MessagePack::Type).from_msgpack(input)
rescue MessagePack::TypeCastError
  dismantle Array(MessagePack::Type).from_msgpack(input)
end
