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

puts '--------------------'
puts 'start'
puts '--------------------'

cur = Dir.pwd + '/'
i = 0 # 連番用
not_jpg = Array.new # jpg以外のリスト

if !Dir.exist?('pic')
  Dir.mkdir('pic')
end

#-------------------------------------------------
# ファイル名を変更しpic/年月へ移動
#-------------------------------------------------

# カレント以下を再帰的に処理
Dir.glob('./**/*').each do |f|

  ext = File.extname(f) # 拡張子取得
  if ext == '.JPG' ||
     ext == '.jpg' ||
     ext == '.jpeg'

    # 移動先ディレクトリ作成
    to_dir_name = cur + '/pic/' + File.mtime(f).strftime('%y%m')
    if !Dir.exist?(to_dir_name)
      Dir.mkdir(to_dir_name)
    end

    # 変更名が移動先に存在する場合、連番を振る
    new_name = to_dir_name + '/' + File.mtime(f).strftime('%y%m%d_%H%M%S') + ext
    if File.exist?(new_name)
      i +=1
      new_name = to_dir_name + '/' + File.mtime(f).strftime('%y%m%d_%H%M%S') + '_' + i.to_s + ext
    end

    # カレントディレクトリを変更（ブロックを抜けると戻る）
    f_dir =  File.dirname(f)
    FileUtils.chdir(f_dir) {
      File.rename(File.basename(f), new_name)
    }
  else
    not_jpg.push(f)
  end

end

puts '--------------------'
puts 'not_jpg_list'
puts '--------------------'
puts not_jpg
