require "gnosis"
require "msgpack"
require "mongo/bson"
#de require "../src/clarity/overrides"
require "../src/clarity/dismantler"

query = {
  "age" => {
    "$gt" => 30,
    "$lt" => 100,
    "$eq" => nil
  },
  "array" => [
    "test",
    1,
    true,
    nil
  ]
}

#de Native Hash to MessagePack encoded string...
Gnosis.debug msgpack = String.new(query.to_msgpack)

#de Encided string to Hash(String, MessagePack::Type)
query_reborn = Hash(String, MessagePack::Type).from_msgpack(msgpack)

#de The goal:
Gnosis.debug bson = Clarity.dismantler(query_reborn) #de .to_bson
Gnosis.debug bson.to_bson, "Dismantled BSON"

Gnosis.debug bson2 = { "test" => true }.to_bson
Gnosis.debug bson2 = { "test1" => true, "test2" => [ true, nil, "false" ] }.to_bson

rows = [
  {
    "0test1" => true,
    "0test2" => "yes",
    "0test3" => 0
  },
  {
    "1test1" => true,
    "1test2" => "yes",
    "1test3" => 0
  }
].to_bson

Gnosis.debug Clarity.dismantler(rows)