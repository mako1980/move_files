require 'fileutils'

cur = Dir.pwd + '/'
i = 0 # �A�ԗp
j = 0 # �A�ԗp
# not_jpg = Array.new # jpg�ȊO�̃��X�g


# �J�����g�ȉ����ċA�I�ɏ���
Dir.glob('./**/*').each do |f|

  if FileTest.directory? f
    if Dir.empty?(f)
      puts f
      #print "#{f}\r"
      Dir.rmdir(f)
    end
  end
end
