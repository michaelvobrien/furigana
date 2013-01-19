# -*- coding: utf-8 -*-
module Furigana
  module Formatter
    class HTML < Formatter::Base
      class << self
        def replacement(surface_form, reading)
          "<ruby><rb>%s</rb><rp>【</rp><rt>%s</rt><rp>】</rp></ruby>" % [surface_form, reading]
        end
      end
    end
  end
end
