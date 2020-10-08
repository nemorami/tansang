enum TknKind
    Lparen  = 40
    Rparen  = 41
    Plus  = 43
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
    Others
    END_list
end

class Token
    def initialize(@kind : TknKind = Others, @text : String = "", intVal : Int32 = 0)
    end    
end

class TokenProcess
    def initialize(@fin : File)
    end
    def nextTkn()
        while (ch = @fin.read_char).whitespace?
            case ctype[ch]
            when TknKind::Letter
                while(ctype[ch] == TknKind::Letter || ctype[ch] == TknKind::Digit)
                    @text += ch
                    ch = @fin.read_char
                end
            when TknKind::Digit
                num = 0
                while(ctype[ch] == Digit)
                    num = num * 10 + ch.to_i
            end
        end
    end
end