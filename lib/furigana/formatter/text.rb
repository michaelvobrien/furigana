# -*- coding: utf-8 -*-
module Furigana
  module Formatter
    class Text < Formatter::Base
      class << self
        def format(parse_tree)
          element, yomi = 0, 1

          text = ""
          parse_tree.each do |el|
            el.each do |part|
              text += if part[yomi].nil?
                        part[element]
                      else
                        "%s【%s】" % [part[element], part[yomi]]
                      end
            end
          end
          text
        end
      end
    end
  end
end
