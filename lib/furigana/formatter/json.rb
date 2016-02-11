require 'json'

module Furigana
  module Formatter
    class JSON < Formatter::Base
      def render
        @kanji_tokens.to_json
      end
    end
  end
end
