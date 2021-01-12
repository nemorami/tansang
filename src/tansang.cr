require "./token_process"

# TODO: Write documentation for `Tansang`
module Tansang
  VERSION = "0.1.0"

  # TODO: Put your code here
end

io = File.open("./src/test.cr")

tp = TokenProcess.new(io)
tp.token_table.print