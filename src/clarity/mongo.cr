require "mongo"

class Mongo::Cursor
  def to_msgpack
    #de rows = Array(Clarity::Row)
    #de each { |row| rows << Clarity::Row.from_bson(row.decode) }
    #de rows.to_msgpack
  end
end
 