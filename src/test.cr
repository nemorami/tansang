class Foo
    macro emphasize(ch, value)
   # ({{value.id}}).each do |e| puts e end
     case {{ch}}
     when {{value.id}}
        puts "true"
     end
    end
  
    def yield_with_self
      with self yield
    end
  end
  
  puts Foo.new.yield_with_self { emphasize('t', "'a'..'t', 'A'..'Z'") }
  