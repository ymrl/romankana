#coding:utf-8
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'kconv'

module RomanKana

  def RomanKana.romankana str
    ret = ''
    array = NKF.nkf('-wZ0',str).downcase.split('')
    buff = [array.shift]
    i = 0
    while i <= array.length
      if a = RomanKana::R2K_table[buff.join('')]
        ret += a
        buff.clear
      elsif buff.length >=2 and buff[0] == 'n' and buff[1] !~ /[aeiou]/
        ret += 'ン'
        buff.shift
      elsif buff.length >=2 and buff[0] == 'm' and buff[1] != /[bmp]/
        ret += 'ン'
        buff.shift
      elsif buff.length >= 2 and buff[0] == buff[1]
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
    ret = [] 
    array = NKF.nkf('-wh2',str).split('')
    buff = [array.shift]
    i = 0
    while i <= array.length
      if a = RomanKana::K2R_table[buff.join('')]
        ret << a
        buff.clear
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
end
class String
  def roman_to_hiragana
    r = self.toutf8.split(/([a-zA-Z]+)/u).map{|e|e =~ /[a-zA-Z]+/u?NKF.nkf("-wh1",RomanKana.romankana(e)):e}.join('')
    Kconv.guess(self) == Kconv::ASCII ? r : Kconv.kconv(r,Kconv.guess(self),Kconv::UTF8)
  end
  def roman_to_katakana
    r = self.toutf8.split(/([a-zA-Z]+)/u).map{|e|e =~ /[a-zA-Z]+/u?RomanKana.romankana(e):e}.join('')
    Kconv.guess(self) == Kconv::ASCII ? r : Kconv.kconv(r,Kconv.guess(self),Kconv::UTF8)
  end
  def katakana_to_roman
    Kconv.kconv(self.toutf8.split(/([ァ-ヴ]+)/u).map{|e|e =~ /[ァ-ヴ]+/u?RomanKana.kanaroman(e):e}.join(''),Kconv.guess(self),Kconv::UTF8)
  end
  def hiragana_to_roman
    Kconv.kconv(self.toutf8.split(/([ぁ-ん]+)/u).map{|e|e =~ /[ぁ-ん]+/u?NKF.nkf("-wh1",RomanKana.kanaroman(e)):e}.join(''),Kconv.guess(self),Kconv::UTF8)
  end
  def to_roman
    Kconv.kconv(RomanKana.kanaroman(self),Kconv.guess(self),Kconv::UTF8)
  end
  def to_hiragana
    r = NKF.nkf('-wh1',RomanKana.romankana(self))
    Kconv.guess(self) == Kconv::ASCII ? r : Kconv.kconv(NKF.nkf("-wh1",r),Kconv.guess(self),Kconv::UTF8)
  end
  def to_katakana
    r = NKF.nkf('-wh2',RomanKana.romankana(self))
    Kconv.guess(self) == Kconv::ASCII ? r : Kconv.kconv(NKF.nkf("-wh1",r),Kconv.guess(self),Kconv::UTF8)
  end
end
