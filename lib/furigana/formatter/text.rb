module Furigana
  module Formatter
    class Text < Formatter::Base
      class << self
        def replacement(surface_form, reading)
          "%s【%s】" % [surface_form, reading]
        end
      end
    end
  end
end
