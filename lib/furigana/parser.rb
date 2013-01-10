# -*- coding: utf-8 -*-
module Furigana
  # 読み方 - Yomikata - Reading
  class Parser
    def reading(text)
      Mecab.chasen(text).inject([]) do |list, element|
        with_furigana = add_furigana(yomi_to_hiragana(element))
        list.push with_furigana if with_furigana
        list
      end
    end

    private

    def yomi_to_hiragana(element)
      element[:yomi] = choose_yomi(element[:element], element[:yomi])
      element
    end

    def k2h(k)
      return nil if k.nil?
      NKF.nkf("-h1 -w", k)
    end

    def kana?(str)
      /^[ぁ-んァ-ンー]+$/.match(str)
    end

    def number?(str)
      /^[0-9０-９]+$/.match(str)
    end

    def choose_yomi(element, yomi)
      !kana?(element) ?  k2h(yomi) : element
    end

    def sdiff(first, second)
      Diff::LCS.sdiff(first, second)
    end

    def sequence(element)
      element.split('')
    end

    def diff_element(element)
      sdiff(sequence(element[:element]), sequence(element[:yomi]))
    end

    def add_furigana(element)
      states = { kanji_and_yomi: '!', yomi: '+', kana: '=' }
      kanji, yomi = 0, 1

      list = nil
      on_kanji = false
      diff_element(element).each do |part|
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
