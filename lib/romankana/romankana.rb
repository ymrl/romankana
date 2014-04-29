#coding:utf-8
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'kconv'

module RomanKana

  def self.find_kana_from_str str
    return '' if !str
    found = R2K_TABLE[str]
    if found
      return found
    elsif str.length >= 2 && str[0] == 'n' && str[1] == 'n'
      return "ン#{find_kana_from_str(str[2..-1])}"
    elsif str.length > 2 && str[0] == 'n' && str[1] !~ /[aiueoy]/
      return "ン#{find_kana_from_str(str[1..-1])}"
    elsif str.length > 2 && str[0] == 'm' && str[1] != /[bmp]/
      return "ン#{find_kana_from_str(str[1..-1])}"
    elsif str.length >= 2 && str[0] == str[1] && str[0] =~ /[a-z]/
      return "ッ#{find_kana_from_str(str[1..-1])}"
    elsif str.length >= 3
      return "#{str[0]}#{find_kana_from_str(str[1..-1])}"
    else
      return str
    end
  end

  def RomanKana.romankana str
    str = RomanKana.convert_utf8(str)
    ret = ''
    array = NKF.nkf('-WwZ0',str).downcase.split(/([^a-z])/).map do |e|
        e.split(/([^aiueo]*[aiueo])/).delete_if{|e|e.length == 0}
      end.flatten
    ret = array.map{|e| find_kana_from_str e }
    return ret.join('')
  end

  def RomanKana.kanaroman str
    str = RomanKana.convert_utf8(str)
    ret = nil

    temp = NKF.nkf('-Wwh2',str).split('')
    array = []
    temp.each_with_index do |s,i|
      if i + 1 < temp.length
        next_str = temp[i+1]
        if next_str =~ /[ァィゥェォャュョ]/u
          s = "#{s}#{next_str}"
          temp[i+1] = nil
        end
      end
      array.push s if s
    end

    ret = array.map{|e| K2R_TABLE[e] || e }
    ret.each_with_index do |s,i|
      if s == 'ッ'
        if i + 1 < ret.length
          c = ret[i+1].split('').first
          ret[i] = c if c !~ /[aiueo]/
        end
      elsif s == 'ー'
        if i - 1 >= 0
          c = ret[i-1].split('').last
          ret[i] = c if c =~ /[aiueo]/
        end
      end
    end

    return ret.join('')
  end

  def RomanKana.set_encoding_of_before before, after
    e = before.encoding
    return (e == Encoding::US_ASCII or e == Encoding::ASCII_8BIT) ? after : after.encode(e)
  end
  def RomanKana.convert_utf8 str
    return (str.encoding != Encoding::UTF_8) ? str.encode(Encoding::UTF_8) : str
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
  def to_hankaku
    r = NKF.nkf('-Z4xwW',RomanKana.convert_utf8(self))
    return RomanKana.set_encoding_of_before(self,r)
  end
end

