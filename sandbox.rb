text = <<~EOF
  face
  back
  - item 1
  - item 2
  back
  - item 1
  - item 2
EOF

ary = text.split(?\n).map(&:strip)
pp ary
#
# lists = []
# ary.each_with_index do |index, item|
#   # puts index, item
#
# end
# pp list

# def list(ary)
#   i = ary.f
# end

def mklist(ary)
  fu = proc{|acc, i| acc << "<li>#{i}</li>"}
  ary
    .inject([], &fu)
    .unshift('<ul>')
    .push('</ul>')
    .join
end

cols = []
buff = []
text.each_line(chomp: true) do |line|
  if line =~ /^-/
    buff << line.sub(/^- /,'')
  else
    if buff.any?
      cols << mklist(buff)
      buff.clear
    end
    cols << line
  end
end
cols << mklist(buff) if buff.any?

pp cols


# <ul>
#  <li>Coffee</li>
#  <li>Tea</li>
#  <li>Milk</li>
# </ul>
