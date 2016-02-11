module Furigana
  module Formatter
    class Base
      SURFACE_FORM, READING = 0, 1

      def self.format(text, kanji_tokens)
        kanji_tokens_enum = kanji_tokens.to_enum

        new_text = ""
        current_token = next_token(kanji_tokens_enum)
        substring, kanji_char_pos = "", 0

        text.each_char do |char|
          # no more kanji tokens
          if current_token.nil?
            new_text += char
            next
          end

          substring += char

          # not a kanji group match
          unless char == current_token[SURFACE_FORM][kanji_char_pos]
            new_text += substring
            substring, kanji_char_pos = "", 0
            next
          end

          if at_end_of_kanji_group?(kanji_char_pos, current_token)
            # a kanji group match; replace kanji group with formatting
            new_text += replacement(current_token[SURFACE_FORM], current_token[READING])
            current_token = next_token(kanji_tokens_enum)
            substring, kanji_char_pos = "", 0
          else
            # kanji token pos advances with char pos
            kanji_char_pos += 1
          end
        end

        new_text
      end

      private

      def self.at_end_of_kanji_group?(kanji_char_pos, current_token)
        kanji_char_pos == (current_token[SURFACE_FORM].length - 1)
      end

      def self.next_token(kanji_tokens_enum)
        kanji_tokens_enum.next
      rescue StopIteration
        nil
      end
    end
  end
end
