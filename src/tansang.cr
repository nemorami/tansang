# TODO: Write documentation for `Tansang`
module Tansang
  VERSION = "0.1.0" 

  # TODO: Put your code here
end

io = File.open("./README.md")

loop do
  ch = io.read_byte
  
  puts "#{ch}, #{typeof(ch)}"  
 if !ch
    break
  end
end