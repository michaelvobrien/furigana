module Furigana
  module Formatter
    class Base
      SURFACE_FORM, READING = 0, 1

      def initialize(text, kanji_tokens)
        @text = text
        @kanji_tokens = kanji_tokens
      end

      def render
        reset

        @text.each_char do |char|
          if no_more_kanji_tokens?
            @new_text += char
            next
          end

          @substring += char

          if not_a_kanji_group_match? char
            @new_text += @substring
            reset_substring
            next
          end

          if kanji_group_match?
            # replace kanji group with formatting
            @new_text += replacement(@current_token[SURFACE_FORM], @current_token[READING])
            @current_token = next_token
            reset_substring
          else
            # kanji token pos advances with char pos
            increment_kanji_char_pos
          end
        end

        @new_text
      end

      private

      def reset
        @new_text = ""
        reset_substring

        @kanji_tokens_enum = @kanji_tokens.to_enum
        @current_token = next_token
      end

      def reset_substring
        @substring = ""
        @kanji_char_pos = 0
      end

      def increment_kanji_char_pos
        @kanji_char_pos += 1
      end

      def no_more_kanji_tokens?
        @current_token.nil?
      end

      def not_a_kanji_group_match?(char)
        current_kanji_char = @current_token[SURFACE_FORM][@kanji_char_pos]
        char != current_kanji_char
      end

      def kanji_group_match?
        @kanji_char_pos == (@current_token[SURFACE_FORM].length - 1)
      end

      def next_token
        @kanji_tokens_enum.next
      rescue StopIteration
        nil
      end

      def replacement(surface_form, reading)
        fail NotImplementedError, "#{self.class} must implement `#{__method__}`"
      end
    end
  end
end
