module Furigana
  module Formatter
    class JSON < Formatter::Base
      class << self
        def format(parse_tree)
          parse_tree.to_json
        end
      end
    end
  end
end
