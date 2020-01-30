require "./value"
require "popcorn"

module Clarity

  def self.dismantler(a)
    dismantle_hash(a)
  end

  def self.dismantle_hash(h)
    clean = Hash(String, Clarity::Value).new
    h.each { |k,v|
      Gnosis.debug "#{k.class} => #{v.class}"
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

  def self.dismantle_else(d) : String | Bool | Int32 | Int64 | Float64 | Nil
    if d.is_a?(String)
      d.as(String)
    elsif d.is_a?(Bool)
      d.as(Bool)
    elsif d.is_a?(Int32)
      d.as(Int32)
    elsif d.is_a?(Int64)
      d.as(Int64)
    elsif d.is_a?(Float64)
      d.as(Float64)
    elsif d.is_a?(UInt64)
      Popcorn.to_int64(d) #de .as(Int64)
    elsif d.is_a?(UInt8) || d.is_a?(UInt16) || d.is_a?(UInt32)
      Gnosis.warn(d.class, "typeof d")
      Popcorn.to_int32(d)
    elsif d.nil?
      nil
    else
      Gnosis.warn(d.class, "typeof d unknown")
      nil
    end
  end
end