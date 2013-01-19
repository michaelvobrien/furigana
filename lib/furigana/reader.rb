# -*- coding: utf-8 -*-
module Furigana
  class Reader
    def reading(text)
      Mecab.tokenize(text).inject([]) do |list, token|
        with_furigana = add_furigana(token)
        list += with_furigana if with_furigana
        list
      end
    end

    private

    def k2h(k)
      return nil if k.nil?
      NKF.nkf("-h1 -w", k)
    end

    def sdiff(first, second)
      Diff::LCS.sdiff(first, second)
    end

    def diff_token_surface_form_and_reading(token)
      sdiff(k2h(token[:surface_form]), k2h(token[:reading]))
    end

    def add_furigana(token)
      states = { kanji_and_yomi: '!', yomi: '+', kana: '=' }
      kanji, yomi = 0, 1

      list = []
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
      list
    end
  end
end
