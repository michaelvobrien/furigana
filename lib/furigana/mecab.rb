# -*- coding: utf-8 -*-
require 'open3'

module Furigana
  class Mecab
    class << self
      def k2h(k)
        return nil if k.nil?
        NKF.nkf("-h1 -w", k)
      end

      def sanitize_text(text)
        text.tr("\n", "")
      end

      def kana?(str)
        /^[ぁ-んァ-ンー]+$/.match(str)
      end

      def number?(str)
        /^[0-9０-９]+$/.match(str)
      end

      def choose_yomi(element, yomi)
        !kana?(element) ?  k2h(yomi) : element
      end

      def chasen(text)
        element, yomi = 0, 1
        stdout, stderr, status = Open3.capture3("mecab -Ochasen", :stdin_data => sanitize_text(text))
        stdout.split("\n").inject([]) do |output, line|
          columns = line.split("\t")
          output << {
            :element => columns[element],
            :yomi    => choose_yomi(columns[element], columns[yomi])
          } if columns[element] != 'EOS'
          output
        end
      end
    end
  end
end
