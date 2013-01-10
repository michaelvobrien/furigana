# -*- coding: utf-8 -*-
module Furigana
  module Formatter
    class Text < Formatter::Base
      class << self
        def replacement(original, yomi)
          "%s【%s】" % [original, yomi]
        end
      end
    end
  end
end
