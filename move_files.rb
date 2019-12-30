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

puts '--------------------'
puts 'start'
puts '--------------------'

cur = Dir.pwd + '/'
i = 0 # �A�ԗp
not_jpg = Array.new # jpg�ȊO�̃��X�g

if !Dir.exist?('pic')
  Dir.mkdir('pic')
end

#-------------------------------------------------
# �t�@�C������ύX��pic/�N���ֈړ�
#-------------------------------------------------

# �J�����g�ȉ����ċA�I�ɏ���
Dir.glob('./**/*').each do |f|

  ext = File.extname(f) # �g���q�擾
  if ext == '.JPG' ||
     ext == '.jpg' ||
     ext == '.jpeg'

    # �ړ���f�B���N�g���쐬
    to_dir_name = cur + '/pic/' + File.mtime(f).strftime('%y%m')
    if !Dir.exist?(to_dir_name)
      Dir.mkdir(to_dir_name)
    end

    # �ύX�����ړ���ɑ��݂���ꍇ�A�A�Ԃ�U��
    new_name = to_dir_name + '/' + File.mtime(f).strftime('%y%m%d_%H%M%S') + ext
    if File.exist?(new_name)
      i +=1
      new_name = to_dir_name + '/' + File.mtime(f).strftime('%y%m%d_%H%M%S') + '_' + i.to_s + ext
    end

    # �J�����g�f�B���N�g����ύX�i�u���b�N�𔲂���Ɩ߂�j
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
