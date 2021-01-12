class TokenTable
  # TokenKind nil??
  @data = [] of {Int32, String, TokenKind?}  
  def push_token(line_no : Int32, token : String, @kind : TokenKind?)
    @data.push({line_no, token, @kind})
  end

  def print
    @data.each do |e|
      p e
    end
  end
end

enum TokenKind
  Identifier
  Operator
  Delimiter
  Digit
  Float
  String
  Comment
end

class TokenProcess
  getter  token_table

  macro get_rest_token(index, ch, iter, kind, condition)
 
    text = {{ch}}.to_s
    while({{iter}}.has_next? &&(ch = {{iter}}.next_char))          
      case ch
      when {{condition.id}}
        text += ch
      else
        break      
      end
    end
    @token_table.push_token({{index}}, text, {{kind}})
    next    
  end
  
  def initialize(fin : File)
    @token_table = TokenTable.new
  
    fin.each_line.with_index do |line, index|      
      iter = Char::Reader.new(line)
      loop do
        ch = iter.current_char
       
        case ch
          #
          # 공백
          #
        when .whitespace?
          while(iter.has_next? && (ch = iter.next_char))
            case ch
            when .whitespace?
            else
              break
            end
          end          
          next
          #
          # 식별자 구분
          #        
        when 'A'..'Z', 'a'..'z', '_', '@'  # 식별자 구분          
          get_rest_token(index, ch, iter, TokenKind::Identifier, "'A'..'Z', 'a'..'z', '_', '@', '0'..'9'")          
         

          # #
          # 숫자 구분
          #
        when '0'..'9' # 숫자구분      # TODO 정수와 소수 구별
          get_rest_token(index, ch, iter, TokenKind::Digit, "'0'..'9'")
         

          #
          # 주석
          #
        when '#'
          text = ch.to_s
          while(iter.has_next?)
            text += iter.next_char
          end
          @token_table.push_token(index, text, TokenKind::Comment)
          #
          # 구분자
          #
        when '(', ')', ';', ','
          @token_table.push_token(index, ch.to_s, TokenKind::Delimiter)
        when '.'
          get_rest_token(index, ch, iter, TokenKind::Delimiter, "'.'")
        when ':'
          get_rest_token(index, ch, iter, TokenKind::Delimiter, "':'")
          #
          # 연산자
          #
        when '+', '-', '*', '/', '>', '<'  
          get_rest_token(index,ch,iter, TokenKind::Operator, "'='") 
         
        when nil
          break
        end
        if(iter.has_next?)
          ch = iter.next_char
        else
          break
        end
      end
    rescue e
      puts e
      return
    end
 
  end
  
end
