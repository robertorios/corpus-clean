require 'fileutils'
#def lines(file)
#  File.open(file).each_line.count
#end

def remove_bad(files)
  files.sort.each_slice(2) do |pair|
    from, to = pair
#    puts from, to
#    puts 
#FileUtils.rm pair 
     if File.readlines(from).any?{|line| line == "[]\n"}
       FileUtils.rm pair
     end
 #   File.readlines(from).each{|line| puts line; puts line=="[]\n"}
 #   puts
  end
end

def files
  Dir.glob("*")
end

remove_bad files

