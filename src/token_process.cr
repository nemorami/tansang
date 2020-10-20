enum CharKind
  Lparen     = 40
  Rparen     = 41
  Plus       = 43
  Minus
  Multi
  Divi
  Assign
  Comma
  DblQ
  Equal
  NotEq
  Less
  LessEq
  Great
  GreatEq
  If
  Else
  End
  Print
  Ident
  IntNum
  String
  Letter
  Digit
  EofTkn
  Comment
  Whitespace
  Others
  END_list
  EOF
end

class Token
  getter text

  def initialize(@kind : CharKind = Others, @text : String = "")
  end

  def to_s
    "#{@kind}: #{@text}"    

  end
end

class TokenProcess
  @ch : Char?
  @ch_type : CharKind = CharKind::Others

  def initialize(@fin : File)
    getNextChar
  end

  def getNextChar
    @ch = @fin.read_char
    
    if @ch.nil?
      @ch_type = CharKind::EOF
      return
    end
    @ch_type = case @ch.as(Char)
    when Nil
      CharKind::End
    when '0'..'9'
      CharKind::Digit
    when 'A'..'Z', 'a'..'z', '_'
      CharKind::Letter
    when '('
      CharKind::Lparen
    when ')'
      CharKind::Rparen    
    when '#'
      CharKind::Comment
    when ' ', '\t', '\n'
      CharKind::Whitespace
    else
      CharKind::Others
    end    
  end

  def nextTkn : Token? 
    while(@ch_type == CharKind::Whitespace)
      getNextChar
    end
    case @ch_type
    when CharKind::Comment
      line = @fin.gets
      getNextChar
      return Token.new(CharKind::Comment, line || "")
    when CharKind::Letter
      text = ""
      while (@ch_type == CharKind::Letter || @ch_type == CharKind::Digit)
        text += @ch.as(Char)
        getNextChar        
      end
      return Token.new(CharKind::Letter, text)
    when CharKind::Digit
      num = 0
      while (@ch_type == CharKind::Digit)
        num = num * 10 + (@ch.as?(Char).try &.to_i? || 0)
        getNextChar        
      end
      return Token.new(CharKind::Digit, num.to_s)
    when CharKind::EOF
      return nil    
    end

    re = Token.new(@ch_type, @ch.to_s)
    getNextChar
    return re
  end
  
end
