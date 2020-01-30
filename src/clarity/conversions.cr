require "../clarity"

def Clarity.from_msgpack(input)
  dismantle Hash(String, MessagePack::Type).from_msgpack(input)
rescue MessagePack::TypeCastError
  Gnosis.warn("Failed to generate and dismantle Hash; trying Array")
  Gnosis.debug(input, "Clarity.from_msgpack")
  dismantle Array(MessagePack::Type).from_msgpack(input)
end

def Clarity.to_msgpack(data)
  String.new(data.to_msgpack)
end
