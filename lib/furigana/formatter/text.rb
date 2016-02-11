module Furigana
  module Formatter
    class Text < Formatter::Base
      def replacement(surface_form, reading)
        "%s【%s】" % [surface_form, reading]
      end
    end
  end
end
