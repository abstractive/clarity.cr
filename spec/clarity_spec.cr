require "./spec_helper"

Gnosis.debug("Starting", "Clarity")

msgpack_string = String.new({ "test" => true, "me" => 0, "please" => "sir"}.to_msgpack)
Gnosis.debug msgpack_string, "msgpack String of test Hash"
Gnosis.debug Clarity.from_msgpack(msgpack_string).inspect, "Hash of msgpack String"

Gnosis.debug "***********************************************************************"
Gnosis.info("Sending command preparation example...", "Thought")
#de Scenario: Saving query on Thought side, to send a Mind.
query = {
  "age" => {
    "$gt" => 30
  }
}

Gnosis.debug query, "Clarity::Query"
Gnosis.debug query = query.to_msgpack, "msgpack Slices"

msgpack_string = String.new(query)
Gnosis.debug msgpack_string, "msgpack String of Query"

Gnosis.debug "***********************************************************************"
Gnosis.info("Receiving payload preparation example...", "Thought")
msgpack = Clarity.from_msgpack(query)
Gnosis.debug msgpack.inspect, "from_msgpack"


Gnosis.debug "***********************************************************************"
Gnosis.info("Receiving command preparation example...", "Mind")

query = {
  "age" => {
    "$gt" => 30
  },
  "test" => [
    {
      "this" => "test",
      "word" => "nah"
    }
  ]
}

msgpack_string = String.new(query.to_msgpack)
Gnosis.debug msgpack_string, "msgpack String of Query"

Gnosis.debug query.to_bson.inspect, "from_msgpack: command BSON 1"

bson = Hash(String, MessagePack::Type).from_msgpack(msgpack_string)
Gnosis.debug Clarity.dismantler(bson).to_bson.inspect, "from_msgpack: command BSON 2"

#de TODO: Create a BSON object of a command msgpack.

Gnosis.debug "***********************************************************************"
Gnosis.info("Sending payload preparation example...", "Mind")
#de TODO: Create a msgpack of a #to_a Mongo cursor with rows.

#de bson_msgpack = Clarity.from_bson(bson).to_msgpack
#de msgpack_string = String.new(bson_msgpack.to_msgpack)
#de Gnosis.debug msgpack_string, "msgpack String of BSON"