#coding:utf-8
module RomanKana
  R2K_TABLE = {
    'a' => 'ア',
    'i' => 'イ',
    'u' => 'ウ',
    'e' => 'エ',
    'o' => 'オ',
    'ba' => 'バ',   'bya' => 'ビャ',
    'bi' => 'ビ',   'byi' => 'ビィ',
    'bu' => 'ブ',   'byu' => 'ビュ',
    'be' => 'ベ',   'bye' => 'ビェ',
    'bo' => 'ボ',   'byo' => 'ビョ',
    'ca' => 'カ',   'cya' => 'チャ', 'cha' => 'チャ', 
    'ci' => 'シ',   'cyi' => 'チィ', 'chi' => 'チ',   
    'cu' => 'ス',   'cyu' => 'チュ', 'chu' => 'チュ', 
    'ce' => 'セ',   'cye' => 'チェ', 'che' => 'チェ', 
    'co' => 'コ',   'cyo' => 'チョ', 'cho' => 'チョ', 
    'da' => 'ダ',   'dya' => 'ヂャ', 'dha' => 'ドャ', 
    'di' => 'ヂ',   'dyi' => 'ヂィ', 'dhi' => 'ドィ', 
    'du' => 'ヅ',   'dyu' => 'ヂュ', 'dhu' => 'ドュ', 
    'de' => 'デ',   'dye' => 'ヂェ', 'dhe' => 'ドェ', 
    'do' => 'ド',   'dyo' => 'ヂョ', 'dho' => 'ドョ', 
    'fa' => 'ファ', 'fya' => 'フャ',
    'fi' => 'フィ', 'fyi' => 'フィ',
    'fu' => 'フ',   'fyu' => 'フュ',
    'fe' => 'フェ', 'fye' => 'フェ',
    'fo' => 'フォ', 'fyo' => 'フョ',
    'ga' => 'ガ',   'gya' => 'ギャ',
    'gi' => 'ギ',   'gyi' => 'ギィ',
    'gu' => 'グ',   'gyu' => 'ギュ',
    'ge' => 'ゲ',   'gye' => 'ギェ',
    'go' => 'ゴ',   'gyo' => 'ギョ',
    'ha' => 'ハ',   'hya' => 'ヒャ',
    'hi' => 'ヒ',   'hyi' => 'ヒィ',
    'hu' => 'フ',   'hyu' => 'ヒュ',
    'he' => 'ヘ',   'hye' => 'ヒェ',
    'ho' => 'ホ',   'hyo' => 'ヒョ',
    'ja' => 'ジャ', 'jya' => 'ジャ',
    'ji' => 'ジ',   'jyi' => 'ジィ',
    'ju' => 'ジュ', 'jyu' => 'ジュ',
    'je' => 'ジェ', 'jye' => 'ジェ',
    'jo' => 'ジョ', 'jyo' => 'ジョ',
    'ka' => 'カ',   'kya' => 'キャ',
    'ki' => 'キ',   'kyi' => 'キィ',
    'ku' => 'ク',   'kyu' => 'キュ',
    'ke' => 'ケ',   'kye' => 'キェ',
    'ko' => 'コ',   'kyo' => 'キョ',
    'la' => 'ラ',   'lya' => 'リャ',
    'li' => 'リ',   'lyi' => 'リィ',
    'lu' => 'ル',   'lyu' => 'リュ',
    'le' => 'レ',   'lye' => 'リェ',
    'lo' => 'ロ',   'lyo' => 'リョ',
    'ma' => 'マ',   'mya' => 'ミャ',
    'mi' => 'ミ',   'myi' => 'ミィ',
    'mu' => 'ム',   'myu' => 'ミュ',
    'me' => 'メ',   'mye' => 'ミェ',
    'mo' => 'モ',   'myo' => 'ミョ',
    'na' => 'ナ',   'nya' => 'ニャ',
    'ni' => 'ニ',   'nyi' => 'ニィ',
    'nu' => 'ヌ',   'nyu' => 'ニュ',
    'ne' => 'ネ',   'nye' => 'ニェ',
    'no' => 'ノ',   'nyo' => 'ニョ',
    'pa' => 'パ',   'pya' => 'ピャ',
    'pi' => 'ピ',   'pyi' => 'ピィ',
    'pu' => 'プ',   'pyu' => 'ピュ',
    'pe' => 'ペ',   'pye' => 'ピェ',
    'po' => 'ポ',   'pyo' => 'ピョ',
    'qa' => 'クァ',
    'qi' => 'クィ',
    'qu' => 'ク',
    'qe' => 'クェ',
    'qo' => 'クォ',
    'ra' => 'ラ',   'rya' => 'リャ', 'sha' => 'シャ',
    'ri' => 'リ',   'ryi' => 'リィ', 'shi' => 'シ',
    'ru' => 'ル',   'ryu' => 'リュ', 'shu' => 'シュ',
    're' => 'レ',   'rye' => 'リェ', 'she' => 'シェ',
    'ro' => 'ロ',   'ryo' => 'リョ', 'sho' => 'ショ',
    'sa' => 'サ',   'sya' => 'シャ',
    'si' => 'シ',   'syi' => 'シィ',
    'su' => 'ス',   'syu' => 'シュ',
    'se' => 'セ',   'sye' => 'シェ',
    'so' => 'ソ',   'syo' => 'ショ',
    'ta' => 'タ',   'tya' => 'チャ', 'tha' => 'テャ',
    'ti' => 'チ',   'tyi' => 'チィ', 'thi' => 'ティ',
    'tu' => 'ツ',   'tyu' => 'チュ', 'thu' => 'テュ',
    'te' => 'テ',   'tye' => 'チェ', 'the' => 'テェ',
    'to' => 'ト',   'tyo' => 'チョ', 'tho' => 'テョ',
    'va' => 'ヴァ', 'vya' => 'ヴャ',
    'vi' => 'ヴィ', 'vyi' => 'ヴィ',
    'vu' => 'ヴ',   'vyu' => 'ヴュ',
    've' => 'ヴェ', 'vye' => 'ヴェ',
    'vo' => 'ヴォ', 'vyo' => 'ヴョ',
    'wa' => 'ワ',                    'wha' => 'ウァ',
    'wi' => 'ウィ', 'wyi' => 'ヰ',   'whi' => 'ウィ',
    'wu' => 'ウ',                    'whu' => 'ウ',
    'we' => 'ウェ', 'wye' => 'ヱ',   'whe' => 'ウェ',
    'wo' => 'ヲ',                    'who' => 'ウォ',
    'xa' => 'ザ',
    'xi' => 'ジ',
    'xu' => 'ズ',
    'xe' => 'ゼ',
    'xo' => 'ゾ',
    'ya' => 'ヤ',
    'yi' => 'ヰ',
    'yu' => 'ユ',
    'ye' => 'ヱ',
    'yo' => 'ヨ',
    'za' => 'ザ',   'zya' => 'ジャ',
    'zi' => 'ジ',   'zyi' => 'ジィ',
    'zu' => 'ズ',   'zyu' => 'ジュ',
    'ze' => 'ゼ',   'zye' => 'ジェ',
    'zo' => 'ゾ',   'zyo' => 'ジョ',
    'nn' => 'ン',
    'tsu' => 'ツ',
  }
end
