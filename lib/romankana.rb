#coding:utf-8
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
directory = File.expand_path(File.dirname(__FILE__))
require directory+'/romankana/r2k.rb'
require directory+'/romankana/k2r.rb'
require directory+'/romankana/RomanKana.rb'
  
module RomanKana
  VERSION = '0.0.6'
end
