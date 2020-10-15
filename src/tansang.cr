require "./token_process"

# TODO: Write documentation for `Tansang`
module Tansang
  VERSION = "0.1.0"

  # TODO: Put your code here
end

io = File.open("./test")

tp = TokenProcess.new(io)
puts tp.nextTkn()

# ch = nil
# case ch
# when Nil
#   puts "ch is nil"
# when 'A' .. 'Z'
#   puts "ch is capital"

# end

