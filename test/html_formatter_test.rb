# -*- coding: utf-8 -*-
require 'test_helper'

class HTMLFormatterTest < Test::Unit::TestCase
  test "食べる" do
    text = "食べる"
    expected = "<ruby><rb>食</rb><rp>【</rp><rt>た</rt><rp>】</rp></ruby>べる"
    assert_equal expected, Furigana::Formatter::HTML.format(Furigana::Parser.new.reading(text))
  end
  test "勉強" do
    text = "勉強"
    expected = "<ruby><rb>勉強</rb><rp>【</rp><rt>べんきょう</rt><rp>】</rp></ruby>"
    assert_equal expected, Furigana::Formatter::HTML.format(Furigana::Parser.new.reading(text))
  end
  test "細かいお金" do
    text = "細かいお金"
    expected = "<ruby><rb>細</rb><rp>【</rp><rt>こま</rt><rp>】</rp></ruby>かいお<ruby><rb>金</rb><rp>【</rp><rt>かね</rt><rp>】</rp></ruby>"
    assert_equal expected, Furigana::Formatter::HTML.format(Furigana::Parser.new.reading(text))
  end
  test "日本語を勉強する。" do
    text = "日本語を勉強する。"
    expected = "<ruby><rb>日本語</rb><rp>【</rp><rt>にほんご</rt><rp>】</rp></ruby>を<ruby><rb>勉強</rb><rp>【</rp><rt>べんきょう</rt><rp>】</rp></ruby>する。"
    assert_equal expected, Furigana::Formatter::HTML.format(Furigana::Parser.new.reading(text))
  end
end
