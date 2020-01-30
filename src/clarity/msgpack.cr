require "msgpack"
require "./dismantler"

module Clarity

  def self.from_msgpack(input)
    dismantle Hash(String, MessagePack::Type).from_msgpack(input)
  rescue MessagePack::TypeCastError
    dismantle Array(MessagePack::Type).from
  end

end
