require 'erb'

require 'fileutils'

weekday = Time.now.strftime('%A')
simple_template = '?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE tmx SYSTEM "tmx11.dtd">
<tmx version="1.1">
  <header
    creationtool="OmegaT"
    creationtoolversion="2.0.5_4"
    segtype="sentence"
    o-tmf="OmegaT TMX"
    adminlang="EN-US"
    srclang="EN"
    datatype="plaintext"
  >
  </header>
  <body>'


renderer = ERB.new(simple_template)
puts output = renderer.result()

def remove_bad(files)
  files.sort.each_slice(2) do |pair|

    from, to = pair
    from_lines, to_lines = File.readlines(from),File.readlines(to)

            size = from_lines.size >= to_lines.size ? to_lines.size : from_lines.size
            (0...size).each do |index|

                 puts "   <tu>"
                 puts '    <tuv lang="EN">'
                 puts "     <seg>#{to_lines[index][/^(?:[A-Z]*\s?\d+:\d+\s)?(.*)$/u,1]}</seg>"
                 puts "    </tuv>"
                 puts '    <tuv lang="ES">'
                 puts "     <seg>#{from_lines[index][/^(?:[A-Z]*\s?\d+:\d+\s)?(.*)$/u,1]}</seg>"
                 puts "    </tuv>"
                 puts "   </tu>"

            end
  end
end

def files
  Dir.glob("*")
end

remove_bad files

puts "</body>"
puts "</tmx>"
