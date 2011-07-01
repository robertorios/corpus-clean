require 'fileutils'

def remove_bad(files)
  files.sort.each_slice(2) do |pair|
    from, to = pair
    from_lines, to_lines = File.readlines(from),File.readlines(to)
    new_from, new_to = [], []
    size = from_lines.size >= to_lines.size ? to_lines.size : from_lines.size
    (0...size).each do |index|
      if from_lines[index] != to_lines[index] && !bad?(from_lines[index]) && !bad?(to_lines[index])



        new_from << from_lines[index][/^(?:[A-Z]*\s?\d+:\d+\s)?(.*)$/u,1]
        new_to << to_lines[index][/^(?:[A-Z]*\s?\d+:\d+\s)?(.*)$/u,1]
      end
    end
    File.open(from, 'w' ) {|file| file.puts new_from}
    File.open(to, 'w') { |file| file.puts new_to }
  end
end

def bad?(string)
  !!string[/\w\sChapter\s\d+:\d+-?\d*/] || !!string[/Index:/]
end

def files
  Dir.glob("*")
end

remove_bad files
