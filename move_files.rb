require 'fileutils'

#-------------------------------------------------
# カレント配下のファイル※1に対し以下を行う
#   * ファイル名変更 yymmdd_HHMMSS_連番.jpg ※2
#   * pic/年月フォルダへ移動
#
# ※1 jpg, jpeg, JPG
# ※2 連番はファイル名がかぶっている場合に振る
#-------------------------------------------------

# TODO 別フォルダに移動したり、
#      ゴミフォルダは削除するなど

cur = Dir.pwd + '/'
i = 0 # 連番用
j = 0 # 連番用
# not_jpg = Array.new # jpg以外のリスト

# 画像の移動先フォルダを作成
if !Dir.exist?('pic')
  Dir.mkdir('pic')
end

# 画像以外の移動先フォルダを作成
if !Dir.exist?('other')
  Dir.mkdir('other')
end


#-------------------------------------------------
# ファイル名を変更しpic/年月へ移動
#-------------------------------------------------

# カレント以下を再帰的に処理
Dir.glob('./**/*').each do |f|

  ext = File.extname(f) # 拡張子取得

  # 画像
  if ext == '.JPG' || ext == '.jpg' || ext == '.JPEG' || ext == '.jpeg'

    # 移動先ディレクトリ作成
    to_dir_name = cur + '/pic/' + File.mtime(f).strftime('%y%m')
    if !Dir.exist?(to_dir_name)
      Dir.mkdir(to_dir_name)
    end

    # 変更名を作成
    new_name = to_dir_name + '/IMG_' + File.mtime(f).strftime('%y%m%d_%H%M%S') + ext
    if File.exist?(new_name)
      # 移動先に存在する場合、連番を振る
      i +=1
      new_name = to_dir_name + '/IMG_' + File.mtime(f).strftime('%y%m%d_%H%M%S') + '_' + i.to_s + ext
    end

  # 画像以外
  else
    # 移動先ディレクトリ作成
    to_dir_name = cur + '/other'
    # 変更名を作成
    new_name = to_dir_name + '/' + File.mtime(f).strftime('%y%m%d_%H%M%S') + ext
    if File.exist?(new_name)
      j +=1
      # 移動先に存在する場合、連番を振る
      new_name = to_dir_name + '/' + File.mtime(f).strftime('%y%m%d_%H%M%S') + '_' + j.to_s + ext
    end
    # not_jpg.push(f)
  end

  # 移動
  if FileTest.file? f
    if File.basename(f) == 'move_files.rb'
    else
      # カレントディレクトリを変更（ブロックを抜けると戻る）
      FileUtils.chdir(File.dirname(f)) {
        # ファイルを移動
        File.rename(File.basename(f), new_name)
      }
    end
  end

end

puts '--------------------'
puts 'done.'
puts '--------------------'

# puts '--------------------'
# puts 'not_jpg_list'
# puts '--------------------'
# puts not_jpg
