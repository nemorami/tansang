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
  WhiteSpace
  Others
  END_list
  END
end

class Token
  def initialize(@kind : CharKind = Others, @text : String = "")
  end
end

class TokenProcess
  @ch : Char?

  def initialize(@fin : File)
  end

  def getCharType : CharKind
    unless @ch.nil?
      case @ch
      when Nil
        return CharKind::End
      when '0'..'9'
        return CharKind::Digit
      when ('A'..'Z') || ('a'..'z') || '_'
        return CharKind::Letter
      else
        return CharKind::Others
      end
      return CharKind::End      
    end
  end

  def nextTkn : Token?
    text = ""
    loop do
      @ch = @fin.read_char

      # next if ch.whitespace?
      ch_type = getCharType
      case ch_type
      when CharKind::Letter
        while (ch_type == CharKind::Letter || ch_type == CharKind::Digit)
          text += @ch.as(Char)
          @ch = @fin.read_char
          ch_type = getCharType
        end
        puts "text => #{text}"
        return Token.new(CharKind::Letter, text)
      when Nil
        break
      when CharKind::WhiteSpace # 스페이스면 다음 글자를 가져온다.
        @ch = @fin.read_char
      when CharKind::Digit
        num = 0
        while (getCharType == CharKind::Digit)
          num = num * 10 + 0
          if @ch.nil?
            0
          else
            puts typeof(@ch)
          end
          @ch = @fin.read_char
        end
        return Token.new(CharKind::Digit, num.to_s)
      end
    end
  end
end
