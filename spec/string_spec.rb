#coding:UTF-8
require 'spec_helper'
describe String do

  describe '#roman_to_hiragana' do
    it 'converts roman-ji to hiragana' do
      expect('ほげほげhogehogeホゲホゲ'.roman_to_hiragana).to eq 'ほげほげほげほげホゲホゲ'
    end
  end

  describe '#roman_to_katakana' do
    it 'converts roman-ji to katakana' do
      expect('ほげほげhogehogeホゲホゲ'.roman_to_katakana).to eq 'ほげほげホゲホゲホゲホゲ'
    end
  end

  describe '#katakana_to_roman' do
    it 'converts katakana to roman' do
      expect('ほげほげhogehogeホゲホゲ'.katakana_to_roman).to eq 'ほげほげhogehogehogehoge'
    end
  end

  describe '#hiragana_to_roman' do
    it 'converts hiragana to roman' do
      expect('ほげほげhogehogeホゲホゲ'.hiragana_to_roman).to eq 'hogehogehogehogeホゲホゲ'
    end
  end

  describe '#to_roman' do
    it 'converts all kana to roman' do
      expect('ほげほげhogehogeホゲホゲ'.to_roman).to eq 'hogehogehogehogehogehoge'
    end
  end


  describe '#to_hiragana' do
    it 'converts all roman-ji and katakana to hiragana' do
      expect('ほげほげhogehogeホゲホゲ'.to_hiragana).to eq 'ほげほげほげほげほげほげ'
    end
  end

  describe '#to_katakana' do
    it 'converts all roman-ji and hiragana to katakana' do
      expect('ほげほげhogehogeホゲホゲ'.to_katakana).to eq 'ホゲホゲホゲホゲホゲホゲ'
    end
  end


  describe '#to_hankaku' do
    it 'converts katkana and zenkaku alphabet to hankaku' do
      expect('ほげほげhogehogeホゲホゲｈｏｇｅｈｏｇｅ'.to_hankaku).to eq 'ほげほげhogehogeﾎｹﾞﾎｹﾞhogehoge'
    end
  end

end
