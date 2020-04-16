require 'fileutils'

#-------------------------------------------------
# �d������摜�t�@�C�����폜����
# �����ۂɂ͑��폜����duplicate_pic�t�H���_�ֈړ�
#-------------------------------------------------

cur = Dir.pwd + '/'
i = 0 # �J�E���^

# �d���t�@�C���̈ړ���t�H���_���쐬
if !Dir.exist?('duplicate_pic')
  Dir.mkdir('duplicate_pic')
end

# �J�����g�ȉ����ċA�I�ɏ���
Dir.glob('./**/*').each do |f|
  ext = File.extname(f) # �g���q�擾
  # �摜
  if ext == '.JPG' || ext == '.jpg' || ext == '.JPEG' || ext == '.jpeg'
    if i == 0
      $old = f
    else
      # ��r
      if FileUtils.cmp(f, $old)
        new_name = cur + 'duplicate_pic/' + File.basename(f)
        # �J�����g�f�B���N�g����ύX�i�u���b�N�𔲂���Ɩ߂�j
        FileUtils.chdir(File.dirname(f)) {
        # �t�@�C�����ړ�
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
