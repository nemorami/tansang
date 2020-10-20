enum TknKind
  VarName
  IntNum
  Lparen  = 40 # (
  Rparen  = 41 # )
  Multi   = 42
  Plus    = 43
  Minus   = 45
  Divi    = 47
  Assign  = 61
  Print   = 63
  EofTkn
  Others
end

class Token
  getter kind, value

  def initialize(@kind : TknKind, @value : Int32 | Char | String)
  end

  def set(@kind : TknKind, @value : Int32 | Char | String)
  end
end

class Calculator 
  @ch : Char = ' '
  @_statement : String = ""

  def initialize()   
    
    @token = Token.new(TknKind::Others, 0)
    @restack = Array(Int32).new
    @varname = Hash(String, Int32).new
    @index = 0
  end

  def input(str : String)
    @_statement = str
    @index = 0
    @ch = nextChar
  end
  def statement
   
    case @token.kind
    when TknKind::VarName
      varname = @token.value
      nextToken()      
      if @token.kind == TknKind::Assign       
        nextToken()
        expression()      
        @varname[varname.as(String)] = @restack.pop {0}        
      end
      
    when TknKind::Print    
      nextToken()
      expression()
      if @token.kind == TknKind::EofTkn
        puts @restack.pop {"empty"}
      end
    end
  end

  def expression
    term()
    while (@token.kind == TknKind::Plus || @token.kind == TknKind::Minus)
      op = @token.kind
      nextToken()
      term()
      operate(op)
    end
  end

  def term
    factor()
    while (@token.kind == TknKind::Multi || @token.kind == TknKind::Divi)
      op = @token.kind
      nextToken()
      factor()
      operate(op)
    end
  end

  def factor    
    case @token.kind      
    when TknKind::VarName     
      @restack.push(@varname[@token.value])
    when TknKind::IntNum
      @restack.push(@token.value.as(Int32))
    when TknKind::Lparen
      nextToken
      expression
    end
    nextToken
  end

  def operate(op : TknKind)
    d2 = @restack.pop {0}
    d1 = @restack.pop {0}  
    if op == TknKind::Divi && d2 == 0
      puts "division by 0"
    else
      case op
      when TknKind::Plus
        @restack.push(d1 + d2)      
      when TknKind::Minus
        @restack.push(d1 - d1)
      when TknKind::Multi
        @restack.push(d1 * d2)
      when TknKind::Divi
        @restack.push((d1/d2).to_i)
      end
    end
  end

  def nextToken
    if (@ch == '\n')
      return @token.set(TknKind::EofTkn, 0)
    end
    while (@ch.whitespace?)
      @ch = nextChar()
    end
   
    case @ch   
    when .to_i?     
      num : Int32 = 0
      while (@ch.to_i?)      
        num = num * 10 + @ch.to_i 
        @ch = nextChar()
      end
      @token.set(TknKind::IntNum, num)
    when .letter?
      text = ""           
      while (@ch.letter?)        
        text += @ch
        @ch = nextChar()        
      end
      @token.set(TknKind::VarName, text.strip)
    when '(', ')', '+', '-', '*', '/', '=', '?', '\n'
      re = @ch
      @ch = nextChar()
      @token.set(TknKind.new(re.ord), re)
    end   
  end

  def nextChar : Char
    return '\n' if @index >= @_statement.size    
    re = @_statement[@index]    
    @index += 1   
    re
  end

end

cal = Calculator.new
while true
  print "Cal(For quit, press 'Q') => "
  str = gets()
  if str.nil?
    break
  else 
    cal.input(str)
    cal.nextToken
    cal.statement
  end
end
