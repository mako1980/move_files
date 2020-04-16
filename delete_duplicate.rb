require 'fileutils'

#-------------------------------------------------
# 重複する画像ファイルを削除する
# ※実際には即削除せずduplicate_picフォルダへ移動
#-------------------------------------------------

cur = Dir.pwd + '/'
i = 0 # カウンタ

# 重複ファイルの移動先フォルダを作成
if !Dir.exist?('duplicate_pic')
  Dir.mkdir('duplicate_pic')
end

# カレント以下を再帰的に処理
Dir.glob('./**/*').each do |f|
  ext = File.extname(f) # 拡張子取得
  # 画像
  if ext == '.JPG' || ext == '.jpg' || ext == '.JPEG' || ext == '.jpeg'
    if i == 0
      $old = f
    else
      # 比較
      if FileUtils.cmp(f, $old)
        new_name = cur + 'duplicate_pic/' + File.basename(f)
        # カレントディレクトリを変更（ブロックを抜けると戻る）
        FileUtils.chdir(File.dirname(f)) {
        # ファイルを移動
        File.rename(File.basename(f), new_name)
        }
      else
        $old = f
      end
    end
    i += 1
  end
end

puts 'done.'
