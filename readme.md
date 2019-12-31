# move_files

# Overview

写真ファイルの更新日でYYMMフォルダに整理します。

## 動作確認環境

* Windows 10 Home 1909
* ruby 2.6.5

## move_files.rb

カレントディレクトリ配下、全てのjpegファイルに対し、以下の処理をします。

* 更新日をもとにファイル名を IMG_YYMMDD_HHMMSS_連番.jpg に変更します。
* 更新日をもとにYYYMMフォルダを作成しファイルを移動します。

※拡張子jpg, JPG, jpeg, JPEGが対象。これら以外のファイルに対しても名称変更しますが移動先はotherフォルダになります。

※連番は名称が重複する場合のみ振ります。

## select_files.rb

各YYMMフォルダからランダムにn枚選択し、selectフォルダに移動します。

※nは引数で指定。指定なしの場合3。
