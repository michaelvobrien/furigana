require 'nkf'

module Furigana
  module Formatter
    class Yomikata < Formatter::Base
      def replacement(surface_form, reading)
        reading
      end

      def render
        k2h(super)
      end

      private

      def k2h(k)
        return nil if k.nil?
        NKF.nkf("-h1 -w", k)
      end
    end
  end
end
