require 'diff/lcs'
require 'nkf'

module Furigana
  class Reader
    def reading(text)
      Mecab.tokenize(text).reduce([]) do |list, token|
        with_reading = add_reading(token)
        list += with_reading if with_reading
        list
      end
    end

    private

    def k2h(k)
      return nil if k.nil?
      NKF.nkf("-h1 -w", k)
    end

    def diff_token_surface_form_and_reading(token)
      Diff::LCS.sdiff(k2h(token[:surface_form]), k2h(token[:reading]))
    end

    def add_reading(token)
      states = { kanji_and_yomi: '!', yomi: '+', kana: '=' }
      kanji, yomi = 0, 1

      list = []

      if /\p{Han}/.match(token[:surface_form])
        on_kanji = false
        diff_token_surface_form_and_reading(token).each do |part|
          case part.action
          when states[:kanji_and_yomi]
            list.push ['',''] unless on_kanji
            list.last[kanji] += part.old_element
            list.last[yomi] += part.new_element
            on_kanji = true
          when states[:yomi]
            list.last[yomi] += part.new_element
          when states[:kana]
            on_kanji = false
          end
        end
      end

      list
    end
  end
end
