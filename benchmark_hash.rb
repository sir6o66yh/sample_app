require 'benchmark/ips'
STRING_HASH  = { "zero" => "foo" }
SYMBOL_HASH  = { :zero  => "foo" }
INTEGER_HASH = { 0      => "foo" }
Benchmark.ips do |x|
  x.report("String")  {  STRING_HASH["zero"] }
  x.report("Symbol")  {  SYMBOL_HASH[:zero]  }
  x.report("Integer") { INTEGER_HASH[0]      }
  x.compare!
end