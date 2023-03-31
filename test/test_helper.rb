# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "minitest/autorun"
require "anker"
include Anker

class Sandbox
  def self.call
    Dir.mktmpdir([TMPRX]) do |dir|
      Dir.chdir(dir) { yield }
    end
  end
  TMPRX = 'anker'.freeze
end
