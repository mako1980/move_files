require 'fileutils'

#-------------------------------------------------
# �t�H���_���Ƃ�n���I��
#-------------------------------------------------

cur = Dir.pwd + '/'
dir_arr = Array.new
file_arr = Array.new

# �t�H���_���쐬
if !Dir.exist?('select')
  Dir.mkdir('select')
end

# �t�H���_���ƂɎ擾����t�@�C����
if ARGV[0] == nil
  n = 3
else
  n = ARGV[0].to_i
end

# �f�B���N�g���ꗗ���쐬
# �J�����g�ȉ����ċA�I�ɏ���
Dir.glob('./**/*').each do |f|
  if FileTest.directory? f
    if f == './select'
    else
      dir_arr << f
    end
  end
end

# �f�B���N�g�������[�v
dir_arr.each { |d|
  file_arr.clear
  # �f�B���N�g�����Ƃ̉摜�t�@�C���ꗗ�쐬
  Dir.glob(d + '/*').each do |f|
   ext = File.extname(f) # �g���q�擾
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

