# -*- coding: utf-8 -*-
module Furigana
  class Reader
    def reading(text)
      Mecab.tokenize(text).inject([]) do |list, token|
        with_furigana = add_furigana(yomi_to_hiragana(token))
        list.push(with_furigana) if with_furigana
        list
      end
    end

    private

    def yomi_to_hiragana(token)
      token[:reading] = choose_reading(token[:surface_form], token[:reading])
      token
    end

    def k2h(k)
      return nil if k.nil?
      NKF.nkf("-h1 -w", k)
    end

    def kana?(str)
      /^[ぁ-んァ-ンー]+$/.match(str)
    end

    def choose_reading(surface_form, reading)
      !kana?(surface_form) ? k2h(reading) : surface_form
    end

    def sdiff(first, second)
      Diff::LCS.sdiff(first, second)
    end

    def diff_token_surface_form_and_reading(token)
      sdiff(token[:surface_form], token[:reading])
    end

    def add_furigana(token)
      states = { kanji_and_yomi: '!', yomi: '+', kana: '=' }
      kanji, yomi = 0, 1

      list = nil
      on_kanji = false
      diff_token_surface_form_and_reading(token).each do |part|
        case part.action
        when states[:kanji_and_yomi]
          list = ['',''] unless on_kanji
          list[kanji] += part.old_element
          list[yomi] += part.new_element
          on_kanji = true
        when states[:yomi]
          list[yomi] += part.new_element
        when states[:kana]
          on_kanji = false
        end
      end
      list
    end
  end
end
