# coding:UTF-8
require 'spec_helper.rb'

describe RomanKana do

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
