require "../clarity"

def Clarity.from_msgpack(input) : Hash(String, Clarity::Value)
  dismantle Hash(String, MessagePack::Type).from_msgpack(input)
end

def Clarity.to_msgpack(data)
  String.new(data.to_msgpack)
end
