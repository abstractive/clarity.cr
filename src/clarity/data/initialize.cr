module Clarity

  class Data #de < Hash(String, MessagePack::Type)

    property value : Hash(String, MessagePack::Type) = Hash(String, MessagePack::Type).new

    class Rows
      
      property value : Hash(Value, Array(Hash(Value, MessagePack::Type)) | Int32)

      def initialize
        Gnosis.debug("initialize")
        @value = {
            "rows" => Array(Hash(String, MessagePack::Type)).new,
            "pages" => 0,
            "index" => 0,
            "count" => 0
        } #de of Symbol => Array(Hash(Value,Value)) | Int32
      end
    end

    def initialize
      Gnosis.debug("initialize blank")
    end

    def initialize(data : Hash(String, MessagePack::Type))
      Gnosis.debug("initialize Hash(String, MessagePack::Type)")
      @value.merge!(data)
    end

    #de def initialize(data : Rows)
    #de   Gnosis.debug("initialize Hash(String, MessagePack::Type)")
    #de   @value.merge!(data)
    #de end

  end
end
