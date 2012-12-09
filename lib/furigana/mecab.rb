# -*- coding: utf-8 -*-
require 'open3'

module Furigana
  class Mecab
    class << self
      def chasen(text)
        stdout, stderr, status = Open3.capture3("mecab -Ochasen", :stdin_data => text)
        stdout.split("\n").map do |line|
          columns = line.split("\t")
          {
            :element    => columns[0],
            :yomi       => columns[1]
          }
        end[0...-1]
      end
    end
  end
end
