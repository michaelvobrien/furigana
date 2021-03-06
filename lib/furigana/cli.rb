require 'furigana'
require 'singleton'
require 'ostruct'
require 'optparse'

module Furigana
  class CLI
    include Singleton

    def initialize
      @settings = OpenStruct.new
      @settings.format = :text
    end

    def parse_options
      OptionParser.new do |opts|
        opts.banner = "Usage: furigana [options] [file]"

        opts.on("--text", "Add furigana and output text (default)") do
          @settings.format = :text
        end
        opts.on("--html", "Add furigana and output HTML") do
          @settings.format = :html
        end
        opts.on("--yomikata", "Output yomikata only") do
          @settings.format = :yomikata
        end
        opts.on("--json", "Add furigana and output JSON") do
          @settings.format = :json
        end
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
        opts.on_tail("--version", "Show version") do
          puts Furigana::VERSION
          exit
        end
      end.parse!
    end

    def start
      parse_options

      input = ARGF.read
      case @settings.format
      when :text
        puts Formatter::Text.new(input, Reader.new.reading(input)).render
      when :html
        puts Formatter::HTML.new(input, Reader.new.reading(input)).render
      when :yomikata
        puts Formatter::Yomikata.new(input, Reader.new.reading(input)).render
      when :json
        puts Formatter::JSON.new(input, Reader.new.reading(input)).render
      end
    end
  end
end
