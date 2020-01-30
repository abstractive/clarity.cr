module Clarity

  alias Value = Nil | String | Bool |
                Int32 | Int64 |
                Float32 | Float64 |
                Array(Value) |
                Hash(String, Value)

end
