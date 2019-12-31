require 'fileutils'

#-------------------------------------------------
# フォルダごとにn枚選ぶ
#-------------------------------------------------

cur = Dir.pwd + '/'
dir_arr = Array.new
file_arr = Array.new

# フォルダを作成
if !Dir.exist?('select')
  Dir.mkdir('select')
end

# フォルダごとに取得するファイル数
if ARGV[0] == nil
  n = 3
else
  n = ARGV[0].to_i
end

# ディレクトリ一覧を作成
# カレント以下を再帰的に処理
Dir.glob('./**/*').each do |f|
  if FileTest.directory? f
    if f == './select'
    else
      dir_arr << f
    end
  end
end

# ディレクトリ分ループ
dir_arr.each { |d|
  file_arr.clear
  # ディレクトリごとの画像ファイル一覧作成
  Dir.glob(d + '/*').each do |f|
   ext = File.extname(f) # 拡張子取得
   if ext == '.JPG' || ext == '.jpg' || ext == '.JPEG' || ext == '.jpeg'
     file_arr << f
   end
  end

  ln = file_arr.length
  if ln == 0
  else
    file_arr.sample(n).each do |f|
      new_name = cur + '/select/' + File.basename(f)
      FileUtils.cp(f, new_name)
    end
  end
}

