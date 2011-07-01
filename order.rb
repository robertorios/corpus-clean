require 'digest/md5'
require 'fileutils'

def files
  Dir.glob("*").
  sort.
  each_slice(2).
  map { |files| [Digest::MD5.hexdigest(File.read(files[0])), Digest::MD5.hexdigest(File.read(files[1])), files[0], files[1]] if files[0] and files[1] }.
  compact.
  sort_by{|i| [i[0], i[1]]}
end

def remove_duplicate(files)
  previous_md5s = nil
  files.each_with_index do |current_to_and_from_files, index|
    current_md5s = current_to_and_from_files[0..1]
    current_files = current_to_and_from_files[2..3]
#    puts '', index, previous_md5s, current_md5s, ''
    if previous_md5s == current_md5s
#      puts "dup found: #{current_md5s}"
      FileUtils.rm current_files
    else
#      puts "new found: #{current_md5s}"
      previous_md5s = current_md5s and next
    end
  end
end

remove_duplicate files

