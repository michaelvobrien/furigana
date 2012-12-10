# -*- coding: utf-8 -*-
require 'open3'

module Furigana
  class Mecab
    class << self
      def k2h(k)
        return nil if k.nil?
        NKF.nkf("-h1 -w", k)
      end

      def kana?(str)
        /^[ぁ-んァ-ンー]+$/.match(str)
      end

      def number?(str)
        /^[0-9０-９]+$/.match(str)
      end

      def choose_yomi(element, yomi)
        (kana?(element) or number?(element)) ? element : k2h(yomi)
      end

      def chasen(text)
        element, yomi = 0, 1
        stdout, stderr, status = Open3.capture3("mecab -Ochasen", :stdin_data => text)
        stdout.split("\n").map do |line|
          columns = line.split("\t")
          {
            :element => columns[element],
            :yomi    => choose_yomi(columns[element], columns[yomi])
          }
        end[0...-1]
      end
    end
  end
end
