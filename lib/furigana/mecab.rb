# -*- coding: utf-8 -*-
require 'open3'

module Furigana
  class Mecab
    class << self
      def sanitize_text(text)
        text.tr("\n", "")
      end

      def chasen(text)
        element, yomi = 0, 1
        stdout, stderr, status = Open3.capture3("mecab -Ochasen", :stdin_data => sanitize_text(text))
        stdout.split("\n").inject([]) do |output, line|
          columns = line.split("\t")
          output << {
            :element => columns[element],
            :yomi    => columns[yomi]
          } if columns[element] != 'EOS'
          output
        end
      end
    end
  end
end
