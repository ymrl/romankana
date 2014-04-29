$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'romankana'

class String
  def roman_to_hiragana
    r = self.split(/([a-zA-Z]+)/u).map{|e|e =~ /[a-zA-Z]+/u?NKF.nkf("-Wwh1",RomanKana.romankana(e)):e}.join('')
    return RomanKana::Utils.set_encoding_of_before(self,r)
  end
  def roman_to_katakana
    r = self.split(/([a-zA-Z]+)/u).map{|e|e =~ /[a-zA-Z]+/u?RomanKana.romankana(e):e}.join('')
    return RomanKana::Utils.set_encoding_of_before(self,r)
  end
  def katakana_to_roman
    r = self.split(/([ァ-ヴ]+)/u).map{|e|e =~ /[ァ-ヴ]+/u?RomanKana.kanaroman(e):e}.join('')
    return RomanKana::Utils.set_encoding_of_before(self,r)
  end
  def hiragana_to_roman
    r = self.split(/([ぁ-ゔ]+)/u).map{|e|e =~ /[ぁ-ゔ]+/u?NKF.nkf("-Wwh1",RomanKana.kanaroman(e)):e}.join('')
    return RomanKana::Utils.set_encoding_of_before(self,r)
  end
  def to_roman
    r = RomanKana.kanaroman(self)
    return RomanKana::Utils.set_encoding_of_before(self,r)
  end
  def to_hiragana
    r = NKF.nkf('-Wwh1',RomanKana.romankana(self))
    return RomanKana::Utils.set_encoding_of_before(self,r)
  end
  def to_katakana
    r = NKF.nkf('-Wwh2',RomanKana.romankana(self))
    return RomanKana::Utils.set_encoding_of_before(self,r)
  end
  def to_hankaku
    r = NKF.nkf('-Z4xwW',RomanKana::Utils.convert_utf8(self))
    return RomanKana::Utils.set_encoding_of_before(self,r)
  end
end
