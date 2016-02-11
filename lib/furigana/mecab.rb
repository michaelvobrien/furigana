require 'open3'

module Furigana
  class Mecab
    class << self
      def tokenize(text)
        surface_form, reading = 0, 1
        stdout, stderr, status = Open3.capture3("mecab -Ochasen", :stdin_data => sanitize_text(text))

        lines = split_stdout(stdout)

        lines.reduce([]) do |kanji_tokens, line|
          return kanji_tokens if line == 'EOS'

          columns = line.split("\t")
          kanji_tokens << {
            :surface_form => columns[surface_form],
            :reading      => columns[reading]
          }
        end
      end

      private

      def sanitize_text(text)
        format("%s\n", text.tr("\n", ""))
      end

      def split_stdout(stdout)
        # Avoid `ArgumentError - invalid byte sequence in UTF-8`
        if stdout.valid_encoding?
          stdout.split("\n")
        else
          stdout.encode!("UTF-8", "UTF-8", :invalid => :replace, :undef => :replace, :replace => "�")
          stdout.split("\n")
        end
      end
    end
  end
end
