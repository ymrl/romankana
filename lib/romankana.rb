#coding:utf-8
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, 'romankana', 'r2k')
require File.join(directory, 'romankana', 'k2r')
require File.join(directory, 'romankana', 'RomanKana')
  
module RomanKana
  VERSION = '0.0.1'
end
