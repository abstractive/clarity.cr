require "./value"

module Clarity

  def self.dismantle(a)
    if a.is_a?(Hash)
      dismantle_hash(a)
    elsif a.is_a?(BSON)
      dismantle a.decode
    elsif a.is_a?(Array)
      dismantle_array(a)
    else
      dismantle_else(a)
    #de else
    #de   raise ArgumentError.new("Must pass Hash(String, Clarity::Value) to dismantle. Not: #{a.class}")
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

  def self.dismantle_else(d)
    case d
    when String
      d.as(String)
    when Bool
      d.as(Bool) ? true : false
    when Nil
      nil
    when Int32
      d.as(Int32)
    when Int64
      d.as(Int64)
    when Float32
      d.as(Float32)
    when Float64
      d.as(Float64)
    when Time
      #de Gnosis.debug(d.class, "typeof Time")
      d.to_utc.to_rfc3339
    when BSON::Timestamp
      d.timestamp.to_i
    when BSON
      dismantle d.decode
    when BSON::ObjectId
      d.to_s
    when BSON::Symbol
      d.to_s
    when BSON::Binary
      #de Gnosis.debug(d.class, "typeof BSON::Binary")
    when BSON::Code
      #de Gnosis.debug(d.class, "typeof BSON::Code")
    when BSON::MaxKey
      #de Gnosis.debug(d.class, "typeof BSON::MaxKey")
    when BSON::MinKey
      #de Gnosis.debug(d.class, "typeof BSON::MinKey")
    when Regex
      #de Gnosis.debug(d.class, "typeof Regex")
    when UInt64
      d.to_i64
    when UInt8, UInt16, UInt32
      d.to_i32
    else
      #de Gnosis.debug(d.class, "typeof d unknown")
      nil
    end
  end
end