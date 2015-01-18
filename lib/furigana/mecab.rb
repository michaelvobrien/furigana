# -*- coding: utf-8 -*-
require 'open3'

module Furigana
  class Mecab
    class << self
      def sanitize_text(text)
        format("%s\n", text.tr("\n", ""))
      end

      def tokenize(text)
        surface_form, reading = 0, 1
        stdout, stderr, status = Open3.capture3("mecab -Ochasen", :stdin_data => sanitize_text(text))

        # Avoid `ArgumentError - invalid byte sequence in UTF-8`
        lines = if stdout.valid_encoding?
                  stdout.split("\n")
                else
                  stdout.encode!("UTF-8", "UTF-8", :invalid => :replace, :undef => :replace, :replace => "�")
                  stdout.split("\n")
                end

        lines.inject([]) do |output, line|
          columns = line.split("\t")
          output << {
            :surface_form => columns[surface_form],
            :reading      => columns[reading]
          } if columns[surface_form] != 'EOS'
          output
        end
      end
    end
  end
end
