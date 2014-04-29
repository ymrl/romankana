#coding:utf-8
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'kconv'
require 'utils'

module RomanKana
  def self.find_kana_from_str str
    return '' if !str || str.length == 0
    found = R2K_TABLE[str]
    if found
      return found
    elsif str.length >= 2 && str[0] == 'n' && str[1] == 'n'
      return "ン#{find_kana_from_str(str[2..-1])}"
    elsif str.length > 2 && str[0] == 'n' && str[1] !~ /[aiueoy]/
      return "ン#{find_kana_from_str(str[1..-1])}"
    elsif str.length > 2 && str[0] == 'm' && str[1] =~ /[bmp]/
      return "ン#{find_kana_from_str(str[1..-1])}"
    elsif str.length >= 2 && str[0] == str[1] && str[0] =~ /[bcdfghjklmnpqrstvwxyz]/
      return "ッ#{find_kana_from_str(str[1..-1])}"
    elsif str.length >= 2
      return "#{find_kana_from_str(str[0])}#{find_kana_from_str(str[1..-1])}"
    else
      return str
    end
  end

  def self.romankana str
    str = RomanKana::Utils.convert_utf8(str)
    ret = ''
    array = NKF.nkf('-WwZ0',str).downcase.split(/([^a-z])/).map do |e|
        e.split(/([^aiueo]*[aiueo])/).delete_if{|e|e.length == 0}
      end.flatten
    ret = array.map{|e| find_kana_from_str e }
    return ret.join('')
  end

  def self.kanaroman str
    str = RomanKana::Utils.convert_utf8(str)
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
end
