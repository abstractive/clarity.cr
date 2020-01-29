require "./spec_helper"

rows = Clarity::Rows.new

query = {
  "age" => {
    "$gt" => 30
  }
}.to_msgpack

puts query.to_s.inspect

rows.push({
  "String" => "Test",
  "Bool" => true,
  "Nil" => nil,
  "Int32" => 126,
  "Float32" => 126.222,
  "Hash" => {
    "String" => "Test",
    "Int32" => 126
  } of String => Clarity::Type
} of String => Clarity::Type)

puts rows.inspect
