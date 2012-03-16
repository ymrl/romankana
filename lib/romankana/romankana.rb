#coding:utf-8
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'kconv'

module RomanKana

  def RomanKana.romankana str
    str = RomanKana.convert_utf8(str)
    ret = ''
    array = NKF.nkf('-WwZ0',str).downcase.split('')
    buff = [array.shift]
    i = 0
    while i <= array.length
      if a = RomanKana::R2K_table[buff.join('')]
        ret += a
        buff.clear
      elsif buff.length >=2 and buff[0] == 'n' and buff[1] !~ /[aeiouy]/
        ret += 'ン'
        buff.shift
      elsif buff.length >=2 and buff[0] == 'm' and buff[1] =~ /[bmp]/
        ret += 'ン'
        buff.shift
      elsif buff.length >= 2 and buff[0] == buff[1] and buff[0] =~ /[a-z]/
        ret += 'ッ'
        buff.shift
      elsif buff.length >= 3
        ret += buff.shift
        next
      end
      buff << array[i]
      i += 1
    end
    return ret+buff.join('')
  end

  def RomanKana.kanaroman str
    str = RomanKana.convert_utf8(str)
    ret = [] 
    array = NKF.nkf('-Wwh2',str).split('')
    temp_array = []
    array.each{|elm|
      if temp_array.size > 0 && elm =~ /[ャュョ]|[ァィゥェォ]/u
        temp_array[temp_array.size-1] +=  elm
      else
        temp_array.push(elm)
      end
    }
    array = temp_array
    buff = [array.first]
    i = 1
    while i <= array.length
      if a = RomanKana::K2R_table_2[buff.join('')]
        ret << a
        buff.clear
        next if i == array.length
      elsif buff.length >= 2 && a = RomanKana::K2R_table_1[buff[0,buff.length-1].join('')]
        ret << a
        (buff.length-1).times{buff.shift}
        next if i == array.length
      elsif i == array.length && a = RomanKana::K2R_table_1[buff.join('')]
        ret << a
        buff.clear
        next if i == array.length
      elsif buff.length >= 2
        ret << buff.shift
        next
      end
      buff << array[i]
      i += 1
    end
    ret += buff
    while a = ret.index('ッ')
      ret[a] = ret[a+1].split('').first
    end
    return ret.join('')
  end
  def RomanKana.set_encoding_of_before before, after
    if RUBY_VERSION < "1.9"
      return Kconv.guess(before) == Kconv::ASCII ? after : Kconv.kconv(after,Kconv.guess(before),Kconv::UTF8)
    end
    e = before.encoding
    return (e == Encoding::US_ASCII or e == Encoding::ASCII_8BIT) ? after : Kconv.kconv(after,before.encoding,Encoding::UTF_8)
  end
  def RomanKana.convert_utf8 str
    if RUBY_VERSION < "1.9"
      return str.toutf8
    else
      return (str.encoding != Encoding::UTF_8) ? str.toutf8 : str 
    end
  end
end


class String
  def roman_to_hiragana
    r = self.split(/([a-zA-Z]+)/u).map{|e|e =~ /[a-zA-Z]+/u?NKF.nkf("-Wwh1",RomanKana.romankana(e)):e}.join('')
    return RomanKana.set_encoding_of_before(self,r)
  end
  def roman_to_katakana
    r = self.split(/([a-zA-Z]+)/u).map{|e|e =~ /[a-zA-Z]+/u?RomanKana.romankana(e):e}.join('')
    return RomanKana.set_encoding_of_before(self,r)
  end
  def katakana_to_roman
    r = self.split(/([ァ-ヴ]+)/u).map{|e|e =~ /[ァ-ヴ]+/u?RomanKana.kanaroman(e):e}.join('')
    return RomanKana.set_encoding_of_before(self,r)
  end
  def hiragana_to_roman
    r = self.split(/([ぁ-ゔ]+)/u).map{|e|e =~ /[ぁ-ゔ]+/u?NKF.nkf("-Wwh1",RomanKana.kanaroman(e)):e}.join('')
    return RomanKana.set_encoding_of_before(self,r)
  end
  def to_roman
    r = RomanKana.kanaroman(self)
    return RomanKana.set_encoding_of_before(self,r)
  end
  def to_hiragana
    r = NKF.nkf('-Wwh1',RomanKana.romankana(self))
    return RomanKana.set_encoding_of_before(self,r)
  end
  def to_katakana
    r = NKF.nkf('-Wwh2',RomanKana.romankana(self))
    return RomanKana.set_encoding_of_before(self,r)
  end
end

