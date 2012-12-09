module Furigana
  module Formatter
    class HTML < Formatter::Base
      class << self
        def format(parse_tree)
          element, yomi = 0, 1

          text = ""
          parse_tree.each do |el|
            el.each do |part|
              text += if part[yomi].nil?
                        part[element]
                      else
                        "<ruby><rb>%s</rb><rp>(</rp><rt>%s</rt><rp>)</rp></ruby>" % [part[element], part[yomi]]
                      end
            end
          end
          text
        end
      end
    end
  end
end
