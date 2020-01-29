require "msgpack"

class Mongo::Cursor
  def to_msgpack
    rows = Array(Clarity::Row)
    each { |row| rows << Clarity::Row.from_bson(row.decode) }
    rows.to_msgpack
  end
end
 