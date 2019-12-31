require 'fileutils'

cur = Dir.pwd + '/'
i = 0 # 連番用
j = 0 # 連番用
# not_jpg = Array.new # jpg以外のリスト


# カレント以下を再帰的に処理
Dir.glob('./**/*').each do |f|

  if FileTest.directory? f
    if Dir.empty?(f)
      puts f
      #print "#{f}\r"
      Dir.rmdir(f)
    end
  end
end
