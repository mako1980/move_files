require 'fileutils'

#-------------------------------------------------
# �J�����g�z���̃t�@�C����1�ɑ΂��ȉ����s��
#   * �t�@�C�����ύX yymmdd_HHMMSS_�A��.jpg ��2
#   * pic/�N���t�H���_�ֈړ�
#
# ��1 jpg, jpeg, JPG
# ��2 �A�Ԃ̓t�@�C���������Ԃ��Ă���ꍇ�ɐU��
#-------------------------------------------------

# TODO �ʃt�H���_�Ɉړ�������A
#      �S�~�t�H���_�͍폜����Ȃ�

cur = Dir.pwd + '/'
i = 0 # �A�ԗp
j = 0 # �A�ԗp
# not_jpg = Array.new # jpg�ȊO�̃��X�g

# �摜�̈ړ���t�H���_���쐬
if !Dir.exist?('pic')
  Dir.mkdir('pic')
end

# �摜�ȊO�̈ړ���t�H���_���쐬
if !Dir.exist?('other')
  Dir.mkdir('other')
end


#-------------------------------------------------
# �t�@�C������ύX��pic/�N���ֈړ�
#-------------------------------------------------

# �J�����g�ȉ����ċA�I�ɏ���
Dir.glob('./**/*').each do |f|

  ext = File.extname(f) # �g���q�擾

  # �摜
  if ext == '.JPG' || ext == '.jpg' || ext == '.JPEG' || ext == '.jpeg'

    # �ړ���f�B���N�g���쐬
    to_dir_name = cur + '/pic/' + File.mtime(f).strftime('%y%m')
    if !Dir.exist?(to_dir_name)
      Dir.mkdir(to_dir_name)
    end

    # �ύX�����쐬
    new_name = to_dir_name + '/IMG_' + File.mtime(f).strftime('%y%m%d_%H%M%S') + ext
    if File.exist?(new_name)
      # �ړ���ɑ��݂���ꍇ�A�A�Ԃ�U��
      i +=1
      new_name = to_dir_name + '/IMG_' + File.mtime(f).strftime('%y%m%d_%H%M%S') + '_' + i.to_s + ext
    end

  # �摜�ȊO
  else
    # �ړ���f�B���N�g���쐬
    to_dir_name = cur + '/other'
    # �ύX�����쐬
    new_name = to_dir_name + '/' + File.mtime(f).strftime('%y%m%d_%H%M%S') + ext
    if File.exist?(new_name)
      j +=1
      # �ړ���ɑ��݂���ꍇ�A�A�Ԃ�U��
      new_name = to_dir_name + '/' + File.mtime(f).strftime('%y%m%d_%H%M%S') + '_' + j.to_s + ext
    end
    # not_jpg.push(f)
  end

  # �ړ�
  if FileTest.file? f
    if File.basename(f) == 'move_files.rb'
    else
      # �J�����g�f�B���N�g����ύX�i�u���b�N�𔲂���Ɩ߂�j
      FileUtils.chdir(File.dirname(f)) {
        # �t�@�C�����ړ�
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
