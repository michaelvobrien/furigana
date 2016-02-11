require 'json'

module Furigana
  module Formatter
    class JSON < Formatter::Base
      class << self
        def format(text, tokens)
          tokens.to_json
        end
      end
    end
  end
end
