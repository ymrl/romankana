# coding:UTF-8
require 'spec_helper.rb'

describe RomanKana do

  describe "#find_kana_from_str" do
    let(:given){ '' }
    before do
      @got = RomanKana.find_kana_from_str given
    end

    context 'non-alphabet string given' do
      let(:given){ 'あ' }

      it 'returns given string' do
        expect(@got).to eq given
      end
    end

    context 'string starts with nn given' do
      let(:given){ 'nnya' }

      it 'returns ン...' do
        expect(@got).to eq 'ンヤ'
      end
    end

    context 'string stats with n given' do
      context 'next to consonant' do
        let(:given){ 'nga' }

        it 'returns ンガ' do
          expect(@got).to eq 'ンガ'
        end
      end
      context 'next to vowel' do
        let(:given){ 'nya' }

        it 'returns ニャ' do
          expect(@got).to eq 'ニャ'
        end
      end
    end

    context 'string stats with m given' do
      context 'means ン' do
        let(:given){ 'mba' }

        it 'returns ンバ' do
          expect(@got).to eq 'ンバ'
        end
      end

      context 'next to vowel' do
        let(:given){ 'ma' }

        it 'returns マ' do
          expect(@got).to eq 'マ'
        end
      end

      context 'nonsense' do
        let(:given){ 'mdo' }

        it 'returns mド' do
          expect(@got).to eq 'mド'
        end
      end
    end

    context 'string starts with same 2 alphabet given' do
      context 'that is consonant' do
        let(:given){'tto'}

        it 'returns ット' do
          expect(@got).to eq 'ット'
        end
      end

      context 'that is vowel' do
        let(:given){'aada'}

        it 'returns アアダ' do
          expect(@got).to eq 'アアダ'
        end
      end
    end

    context 'long string given' do
      let(:given){ 'aaaaaaaa' }

      it 'returns アアアアアアア' do
        expect(@got).to eq 'アアアアアアアア'
      end
    end
  end

  describe "#romankana" do
    let(:given){ '' }
    before do
      @got = RomanKana.romankana given
    end

    context 'hiragana given' do
      let(:given) { 'あのいーはとーゔぉのすきとおったかぜ' }

      it 'does nothing' do
        expect(@got).to eq given
      end
    end

    context 'katakana given' do
      let(:given) { 'アノイーハトーヴォノスキトオッタカゼ' }

      it 'does nothing' do
        expect(@got).to eq given
      end

    end


    context 'roman-ji given' do
      let(:given) { 'ano iihatoovo no sukitootta kaze' }
      it 'returns katakana' do
        expect(@got).to eq 'アノ イイハトオヴォ ノ スキトオッタ カゼ'
      end
    end

    context 'ン given' do
      context 'in nn' do
        let(:given){'kouennji himonnya'}

        it 'handles nn as ン' do
          expect(@got).to eq 'コウエンジ ヒモンヤ'
        end
      end

      context 'in n' do
        let(:given){'kouenji himonya'}

        it 'handles n as ン' do
          expect(@got).to eq 'コウエンジ ヒモニャ'
        end
      end
    end

    context 'the Hepburn system given' do
      let(:given){'nishinippori hambaagu'}

      it 'handles in the Hepburn system' do
        expect(@got).to eq 'ニシニッポリ ハンバアグ'
      end
    end

    context 'the kunrei system given' do
      let(:given){'nisinippori hanbaagu'}

      it 'handles in the kunrei system' do
        expect(@got).to eq 'ニシニッポリ ハンバアグ'
      end
    end
  end

  describe "#kanaroman" do
    let(:given){ '' }
    before do
      @got = RomanKana.kanaroman given
    end

    context 'roman-ji given' do
      let(:given) { 'ano iihatoovo no sukitootta kaze' }

      it 'does nothing' do
        expect(@got).to eq given
      end
    end

    context 'hiragana given' do
      let(:given) { 'あのいーはとーゔぉのすきとおったかぜ' }

      it 'converts to roman-ji' do
        expect(@got).to eq 'anoiihatoovonosukitoottakaze'
      end

    end

    context 'katakana given' do
      let(:given) { 'アノイーハトーヴォノスキトオッタカゼ' }

      it 'converts to roman-ji' do
        expect(@got).to eq 'anoiihatoovonosukitoottakaze'
      end
    end

    context 'ン given' do
      context 'in nn' do
        let(:given){'コウエンジ ヒモンヤ'}

        it 'handles ン' do
          expect(@got).to eq 'kouenji himonya'
        end
      end
    end

    context 'ー and ッ given' do
      let(:given){'マークザッカーバーグ アーノルドシュワルツネッガー'}

      it 'changes ー' do
        expect(@got).to eq 'maakuzakkaabaagu aanorudoshuwarutsuneggaa'
      end
    end
  end
end
