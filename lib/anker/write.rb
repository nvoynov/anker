module Anker

  class Write
    def self.call(name, notes)
      new.(name, notes)
    end

    private_class_method :new

    def call(name, notes)
      rever = notes.select{|n| n.is_a? Reversible}
      other = notes.reject{|n| n.is_a? Reversible}
      basic = other.reject{|n| n.cloze?}
      cloze = other.select{|n| n.cloze?}
      write("#{name}.basic.csv", basic) if basic.any?
      write("#{name}.cloze.csv", cloze) if cloze.any?
      write("#{name}.rever.csv", rever) if rever.any?
    end

    protected

    def write(name, notes)
      return unless notes.any?
      print "writing #{name}.."
      File.write(name, notes.map(&:csv).join(?\n))
      puts "OK"
    end
  end
end
