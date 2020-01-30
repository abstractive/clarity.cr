require "msgpack"
require "./dismantler"

module Clarity

  def self.from_msgpack(input)
    dismantler Hash(String, MessagePack::Type).from_msgpack(input)
  end

end
