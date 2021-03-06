#!/usr/bin/env python
# -*- coding:utf-8 -*-

'''
Created on 2014/05/29

@author: N2207
'''
import sys
import codecs

# ファイル管理画面
# 各仮想キーコード & 標準設定の場合の機能

file_vkey = {
    '0008': ('BS', '親フォルダへ移動'),
    '0013': ('ENT', '拡張子判別実行 or テキストビュア'),
    '0027': ('ESC', '各処理の中止'),
    '0032': ('SPC', 'マーク'),
    '0033': ('P_UP   ', 'カーソルページアップ'),
    '0034': ('P_DN   ', 'カーソルページダウン'),
    '0035': ('END', '再読込（マーククリア）'),
    '0036': ('HOME   ', 'マーク反転（フォルダ以外）'),
    '0037': ('←', '左ファイル窓へ'),
    '0038': ('↑', 'カーソル移動'),
    '0039': ('→', '右ファイル窓へ'),
    '0040': ('↓', 'カーソル移動'),
    '0045': ('INS', 'ファイル窓のフォント縮小'),
    '0046': ('DEL', 'ファイル窓のフォント拡大'),
    '0049': ('1', '1列表示 & タイトル一覧表示OFF'),
    '0050': ('2', '2列表示'),
    '0051': ('3', '3列表示'),
    '0052': ('4', '4列表示'),
    '0053': ('5', '5列表示'),
    '0054': ('6', '6列表示'),
    '0055': ('7', '7列表示'),
    '0056': ('8', '8列表示'),
    '0057': ('9', '9列表示'),
    '0065': ('a', 'マーク反転（フォルダ以外）'),
    '0067': ('c', '複写'),
    '0068': ('d', '削除'),
    '0069': ('e', 'エディタで編集'),
    '0070': ('f', 'インクリメンタルサーチ'),
    '0071': ('g', '保持画像の表示'),
    '0072': ('h', '履歴ジャンプ'),
    '0073': ('i', '占有合計ファイルサイズ表示'),
    '0074': ('j', '登録フォルダジャンプ'),
    '0075': ('k', 'フォルダの作成'),
    '0076': ('l', 'ドライブ変更'),
    '0077': ('m', '移動'),
    '0078': ('n', 'ネットワークツリー選択'),
    '0079': ('o', '他方と同じパスにする'),
    '0080': ('p', '圧縮'),
    '0081': ('q', '終了'),
    '0082': ('r', 'ファイル情報の編集'),
    '0083': ('s', 'ソート種類変更'),
    '0084': ('t', 'ツリー選択'),
    '0085': ('u', '書庫の展開'),
    '0086': ('v', 'ビュアの起動'),
    '0087': ('w', '同名ファイル比較マーク'),
    '0088': ('x', 'ファイル実行'),
    '0090': ('z', '設定プログラム起動'),
    '0096': ('TEN 0', 'ドライブ変更'),
    '0106': ('TEN *', 'ファイルマスクを*.*にする'),
    '0107': ('TEN +', 'ファイル窓を同サイズにする'),
    '0109': ('TEN -', 'ファイル窓を同サイズにする'),
    '0186': (':', 'マスク選択'),
    '0189': ('−', '擬似ドロップ先選択'),
    '0190': ('.', 'ファイル窓のアイコン表示トグル'),
    '0191': ('/', 'DLL/SPIの情報表示'),
    '0192': ('@', 'ワイルドカードマークの選択'),
    '0226': ('_', 'コンテキストメニュー'),
    '0220': ('\\', 'ルートフォルダへジャンプ'),
    '1013': ('S-ENT', '拡張子判別実行 or エディタで編集'),
    '1032': ('S-SPC', 'マーク+カーソルアップ'),
    '1033': ('S-P_UP', 'メッセージ窓のスクロール（1ページ）'),
    '1034': ('S-P_DN', 'メッセージ窓のスクロール（1ページ）'),
    '1035': ('S-END', '他方の再読込（マーククリア）'),
    '1036': ('S-HOME', 'マーク反転（フォルダ含む）'),
    '1037': ('S', 'メッセージ窓のスクロール（1ページ）'),
    '1038': ('S-↑', 'メッセージ窓のスクロール（1行）'),
    '1039': ('S-→', 'メッセージ窓のスクロール（1ページ）'),
    '1040': ('S-↓', 'メッセージ窓のスクロール（1行）'),
    '1045': ('S-INS  ', 'メッセージ窓のフォント縮小'),
    '1046': ('S-DEL  ', 'メッセージ窓のフォント拡大'),
    '1065': ('S-Ａ', 'マーク反転（フォルダ含む）'),
    '1067': ('S-Ｃ', '登録フォルダへ複写'),
    '1068': ('S-Ｄ', 'ごみ箱を用いた削除'),
    '1069': ('S-Ｅ', '新規テキスト編集'),
    '1070': ('S-Ｆ', 'ファイルの検索'),
    '1071': ('S-Ｇ', 'ファイル名省略位置変更'),
    '1073': ('S-Ｉ', '単純合計ファイルサイズ表示'),
    '1074': ('S-Ｊ', '入力したフォルダにジャンプ'),
    '1076': ('S-Ｌ', '共有フォルダ列挙'),
    '1077': ('S-Ｍ', '登録フォルダへ移動'),
    '1079': ('S-Ｏ', '他方を同じパスにする'),
    '1080': ('S-Ｐ', '個別圧縮'),
    '1081': ('S-Ｑ', '終了（設定保存なし）'),
    '1082': ('S-Ｒ', '拡張改名'),
    '1084': ('S-Ｔ', 'データタイトル一覧表示切替'),
    '1085': ('S-Ｕ', '強制仮想フォルダ'),
    '1086': ('S-Ｖ', 'ボリュームラベル設定'),
    '1087': ('S-Ｗ', '小物メニュー（分割結合・集中複写移動）'),
    '1088': ('S-Ｘ', 'ファイル名を入力して実行'),
    '1090': ('S-Ｚ', '各種設定一時切替メニュー'),
    '1186': ('S-：', 'ファイルマスク入力'),
    '1192': ('S-＠', 'ワイルドカードマークの直接入力'),
    '1190': ('S-．', 'ファイル窓のサムネイル表示トグル'),
    '1226': ('S-＿', '右 D&D シミュレーション'),
    '2013': ('C-ENT  ', '関連付けで開く'),
    '2032': ('C-SPC  ', '直上のマークからカーソル位置までマーク'),
    '2033': ('C-P_UP ', 'カーソルを最上部へ'),
    '2034': ('C-P_DN ', 'カーソルを最下部へ'),
    '2035': ('C-END  ', '再読込（マーク保持）'),
    '2037': ('C-←', '前の有効ドライブに変更'),
    '2038': ('C-↑', 'カーソルページアップ'),
    '2039': ('C-→', '後の有効ドライブに変更'),
    '2040': ('C-↓', 'カーソルページダウン'),
    '2045': ('C-INS  ', 'マイコンピュータのコンテキストメニュー'),
    '2046': ('C-DEL  ', 'ごみ箱のコンテキストメニュー'),
    '2186': ('C-：', 'マークサーチ（下方向）'),
    '3032': ('S-C-SPC', '直下のマークからカーソル位置までマーク'),
    '3033': ('S-C-PUP', 'サムネイルサイズ縮小'),
    '3034': ('S-C-PDN', 'サムネイルサイズ拡大'),
    '3035': ('S-C-END', '他方の再読込（マーク保持）'),
    '3037': ('S-C-← ', 'フォルダ履歴を戻る'),
    '3038': ('S-C-↑ ', 'ファイル表示の並び替え'),
    '3039': ('S-C-→ ', 'フォルダ履歴を進む'),
    '3040': ('S-C-↓ ', 'ファイル表示の並び替え'),
    '3045': ('S-C-INS', 'ファイル窓の行間縮小'),
    '3046': ('S-C-DEL', 'ファイル窓の行間拡大'),
    '3186': ('S-C-： ', 'マークサーチ（上方向）'),
    '4037': ('A-←', 'ファイル窓大きさ変更'),
    '4038': ('A-↑', 'メッセージ窓大きさ変更'),
    '4039': ('A-→', 'ファイル窓大きさ変更'),
    '4040': ('A-↓', 'メッセージ窓大きさ変更'),
    '4090': ('A-Ｚ', 'あふｗをもう１つ開く（作業中でも可）'),
    '4226': ('A-＿', 'ファイル名クリップボード転送メニュー'),
    '5090': ('A-S-Ｚ ', 'あふｗをもう１つ開く（管理者権限）'),
}


def vkey2rkey(vkey):
    '''仮想キーから、実際のキーへの変換'''

    combination_rkey = ''
    if int(vkey[0]) & 2:
        combination_rkey += 'ctrl+'
    if int(vkey[0]) & 1:
        combination_rkey += 'shift+'
    if int(vkey[0]) & 4:
        combination_rkey += 'alt+'

    single_vkey = ''.join(('0', vkey[1:]))
    if single_vkey in file_vkey:
        single_rkey = file_vkey[single_vkey][0]
        return ''.join((combination_rkey, ' ', single_rkey))
    else:
        return '[Warning] Invalid key definition : %s' % vkey


def vkey2function(vkey):
    '''仮想キーから、機能への変換'''

    if vkey in file_vkey:
        return file_vkey[vkey][1]
    else:
        return '[Warning] No Function : %s' % vkey


def is_keydefinition(line):
    '''キー定義行なのか判定'''
    # キー定義の判定は暫定（1000個を超えるキー定義はないので実質問題ない）
    if line[:2] == 'K0':
        return True
    else:
        return False


def conv_readable_keydefiniton(line):
    '''人に読める形でキー定義を返す'''
    def_number = line[:5]
    vkey = line[7:11]
    rkey = vkey2rkey(vkey)

    # 仮想キー → 仮想キーの置換ケース
    if line[11] == ':':
        replace_vkey = line[12:16]
        function = vkey2function(replace_vkey)
    else:
        function = line[11:].strip()

    return ''.join((def_number, ': ', rkey.ljust(15), ': ', function, '\n'))


def test_main():
    print(vkey2rkey('7013'))
    print(vkey2rkey('1000'))
    print(vkey2function('1068'))
    print(vkey2function('0044'))
    print(is_keydefinition('[NORMAL]'))
    print(is_keydefinition('K0000="1013:2013"'))
    print(conv_readable_keydefiniton('K0000="1013:2013"'))
    print(conv_readable_keydefiniton('K0018="3090$~\K3KEYAFX.exe"'))


def main():
    afxwkey_file = 'D:\\home\\kimitaka\\tool\\afxw\\AFXW.KEY'
    readable_afxwkey_file = 'D:\\home\\kimitaka\\tool\\afxw\\AFXW_READABLE.KEY'

    with codecs.open(afxwkey_file, 'r', 'shift-jis') as afxwkey:
        definitions = []
        for line in afxwkey:
            if is_keydefinition(line):
                print(conv_readable_keydefiniton(line).strip())
                definitions.append(conv_readable_keydefiniton(line))
        else:
            with codecs.open(readable_afxwkey_file, 'w', 'utf-8') as out:
                out.writelines(definitions)

if __name__ == '__main__':
    # sys.exit(test_main() or 0)
    sys.exit(main() or 0)
