module Anker

  # Anki basic note with face and back only, naturally cauld be Cloze
  #   it also serves for Basic and Reversible
  class Basic
    attr_reader :face, :back

    def initialize(lines)
      head, *tail = lines.map(&:strip)
      @face = mkline(head)
      @back = mkback(tail)
      @clze = @face =~ /{{/
    end

    def cloze?
      @clze
    end

    def csv(delimiter = ?|)
      [@face, @back].join(delimiter)
    end

    protected

    def mkback(lines)
      [].tap do |cols|
        buff = []
        lines.each do |line|
          if line =~ /^-/
            buff << line.sub(/^- /,'')
          else
            if buff.any?
              cols << mklist(buff)
              buff.clear
            end
            cols << mkline(line)
          end
        end
        cols << mklist(buff) if buff.any?
      end.join ?\s
    end

    def mkline(from)
      # line.split(?|).map{|l| "<p>#{l.strip}</p>" }.join(?\s)
      line = from.split(?|).map(&:strip).join('</br>')
      "<p>#{line}</p>"
    end

    def mklist(from)
      fu = proc{|acc, i| acc << "<li>#{i}</li>"}
      from
        .inject([], &fu)
        .unshift('<ul>')
        .push('</ul>')
        .join
    end
  end

  # It serves for Basic optionally Reversible
  class Reversible < Basic
    def initialize(lines)
      last = lines.pop
      fail ArgumentError.new("last line must be 'y/n'"
      ) unless last == ?y || last == ?n
      @revs = last == ?y
      super(lines)
      fail ArgumentError, "note cannot be Cloze and Reversible" if self.cloze?
    end

    def csv(delimiter = ?|)
      [@face, @back, @revs == true ? ?y : ?n].join(delimiter)
    end
  end

end
