require 'fileutils'
def lines(file)
  File.open(file).each_line.count
end

def remove_bad(files)
  files.sort.each_slice(2) do |pair|
    from, to = pair
    FileUtils.rm pair unless lines(from) == lines(to)
  end
end

def files
  Dir.glob("*")
end

remove_bad files
~                 
