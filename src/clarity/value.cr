module Clarity

  alias Value = Nil | String | Bool |
                Int64 |
                Int32 |
                Float64 |
                Array(Value) |
                Hash(String, Value)

                #de Lowest common denominator is BSON
                #de which doesn't support these:

                #de Int16 |
                #de Int8 |
                #de UInt64 |
                #de UInt32 |
                #de UInt16 |
                #de UInt8 |

end
