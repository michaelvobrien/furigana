# -*- coding: utf-8 -*-
module Furigana
  module Formatter
    class HTML < Formatter::Base
      class << self
        def replacement(original, yomi)
          "<ruby><rb>%s</rb><rp>【</rp><rt>%s</rt><rp>】</rp></ruby>" % [original, yomi]
        end
      end
    end
  end
end
