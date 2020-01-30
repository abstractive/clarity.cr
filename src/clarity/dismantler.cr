require "./types"
require "mongo"

module Clarity

  def self.dismantle(a)
    #de Gnosis.debug a.inspect, "dismantle"
    if a.is_a?(Hash)
      dismantle_hash(a)
    elsif a.is_a?(Array)
      dismantle_array(a)
    else
      dismantle_else(a)
    end
  end

  def self.dismantle_hash(h) : Hash(String, Clarity::Value)
    clean = Hash(String, Clarity::Value).new
    h.each { |k,v|
      clean[k.as(String)] = if v.is_a?(Hash)
        dismantle_hash(v)
      elsif v.is_a?(Array)
        dismantle_array(v)
      else
        dismantle_else(v)
      end
    }
    clean
  end

  def self.dismantle_array(a)
    clean = Array(Clarity::Value).new
    a.each { |i|
      if i.is_a?(Hash)
        clean.push dismantle_hash(i)
      elsif i.is_a?(Array)
        clean.push dismantle_array(i)
      else
        clean.push dismantle_else(i)
      end
    }
    clean
  end

  def self.dismantle_else(d) #de : String | Bool | Int32 | Int64 | Float32 | Float64 | Nil
    if d.is_a?(BSON)
      #de Gnosis.debug(d.class, "typeof BSON")
      dismantle d.decode
    elsif d.is_a?(Mongo::Cursor)
      #de Gnosis.debug(d.class, "typeof BSON")
      dismantle d.to_a
    elsif d.is_a?(BSON::ObjectId)
      #de Gnosis.debug(d.class, "typeof BSON::ObjectId")
      d.to_s
    elsif d.is_a?(BSON::Symbol)
      #de Gnosis.debug(d.class, "typeof BSON::Symbol")
      d.to_s
    elsif d.is_a?(BSON::Binary)
      Gnosis.debug(d.class, "typeof BSON::Binary")
    elsif d.is_a?(BSON::Code)
     Gnosis.debug(d.class, "typeof BSON::Code")
    elsif d.is_a?(BSON::MaxKey)
      Gnosis.debug(d.class, "typeof BSON::MaxKey")
    elsif d.is_a?(BSON::MinKey)
      Gnosis.debug(d.class, "typeof BSON::MinKey")
    elsif d.is_a?(BSON::Timestamp)
      #de Gnosis.debug(d.class, "typeof BSON::Timestamp")
      d.timestamp.to_i
    elsif d.is_a?(Regex)
      Gnosis.debug(d.class, "typeof Regex")
    elsif d.is_a?(Time)
      Gnosis.debug(d.class, "typeof Time")
    elsif d.is_a?(String)
      d.as(String)
    elsif d.is_a?(Bool)
      d.as(Bool)
    elsif d.is_a?(Nil)
      nil
    elsif d.is_a?(Int32)
      d.as(Int32)
    elsif d.is_a?(Int64)
      d.as(Int64)
    elsif d.is_a?(Float32)
      d.as(Float32)
    elsif d.is_a?(Float64)
      d.as(Float64)
    elsif d.is_a?(UInt64)
      d.to_i64
    elsif d.is_a?(UInt8) || d.is_a?(UInt16) || d.is_a?(UInt32)
      d.to_i32
    else
      #de Gnosis.debug(d.class, "typeof d unknown")
      nil
    end
  end
end