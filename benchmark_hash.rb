require 'benchmark/ips'
STRING_HASH = { "ne" => "ko" }
SYMBOL_HASH = { :ne => "ko"}
INGEGER_HASH = { 1 => "ko" }
Benchmark.ips do |x|
  x.report("String") { STRING_HASH["ne"] }
  x.report("Symbol") { SYMBOL_HASH[:ne] }
  x.report("Integer") { INGEGER_HASH[1] }
  x.compare!
end