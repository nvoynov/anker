require_relative "notes"

module Anker

  # Anker source file parser
  class Parse
    Failure = Class.new(StandardError)

    # @see #call
    def self.call(source)
      new.(source)
    end

    private_class_method :new

    # Parse Anker source file
    # @param source [String] source file
    # @return [Array<Basic|Reversible>] parsed notes
    def call(source)
      [].tap{|notes|
        fu = proc{|lines| notes << note(lines)}
        File.open(source){|f| read(f, &fu)}
      }
    end

    protected

    def note(lines)
      klass = lines.last =~ /^(y|n)$/ ? Reversible : Basic
      klass.new(lines)
    end

    # @todo rescue
    def read(io, &callback)
      memo = []
      io.each do |line|
        s = line.strip
        next if s =~ /^(%|#)/
        if s.empty?
          if memo.any?
            callback.(memo.dup)
            memo.clear
          end
          next
        end
        memo << s
      end
      callback.(memo.dup) if memo.any?
    rescue ArgumentError => e
      msg = <<~EOF
        parsing error at line #{io.lineno - memo.size}: #{e.message}
        #{memo.map{|l| "  #{l}\n"}.join}
      EOF
      fail Failure, msg
    end
  end
end
