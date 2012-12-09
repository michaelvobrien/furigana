# -*- coding: utf-8 -*-
require 'redcarpet'

module Furigana
  # 読み方 - Yomikata - Reading
  class Parser
    def mecab(text)
      stdout, stderr, status = Open3.capture3("mecab -Ochasen", :stdin_data => text)
      stdout
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
      (kana?(element) or number?(element)) ? element : k2h(yomi)
    end

    def meta(text)
      element, yomi = 0, 1
      mecab(text).split("\n").map do |line|
        columns = line.split("\t")
        {
          :element => columns[element],
          :yomi    => choose_yomi(columns[element], columns[yomi])
        }
      end[0...-1]
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

      on_kanji = false
      diff_element(element).inject([]) do |list, part|
        case part.action
        when states[:kanji_and_yomi]
          list.push ['', ''] unless on_kanji
          list.last[kanji] += part.old_element
          list.last[yomi] += part.new_element
          on_kanji = true
        when states[:yomi]
          list.last[yomi] += part.new_element
        when states[:kana]
          on_kanji = false
          list.push [part.old_element, nil]
        end
        list
      end
    end

    def reading(text)
      meta(text).inject([]) do |list, element|
        list.push add_furigana(element)
        list
      end
    end
  end
end
