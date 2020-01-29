module Clarity

  alias Type = String | Bool | Nil |
               UInt8 | UInt16 | UInt32 | UInt64 |
               Int64 | Int32 | Int16 | Int8 | Float64 | Float32 |
               Array(Type) | Hash(String, Type)

  alias Rows = Array(Type)

end

class Array(T)
  def push(*values : Hash(String, Clarity::Type))
    new_size = @size + values.size
    resize_to_capacity(Math.pw2ceil(new_size)) if new_size > @capacity
    values.each_with_index do |value, i|
      @buffer[@size + i] = value
    end
    @size = new_size
    self 
  end
end
