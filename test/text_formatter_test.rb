# -*- coding: utf-8 -*-
require 'test_helper'

class TextFormatterTest < Test::Unit::TestCase
  test "食べる" do
    text = "食べる"
    expected = "[食|た]べる"
    assert_equal expected, Furigana::Formatter::Text.format(Furigana::Parser.new.reading(text))
  end
  test "勉強" do
    text = "勉強"
    expected = "[勉強|べんきょう]"
    assert_equal expected, Furigana::Formatter::Text.format(Furigana::Parser.new.reading(text))
  end
  test "細かいお金" do
    text = "細かいお金"
    expected = "[細|こま]かいお[金|かね]"
    assert_equal expected, Furigana::Formatter::Text.format(Furigana::Parser.new.reading(text))
  end
  test "日本語を勉強する。" do
    text = "日本語を勉強する。"
    expected = "[日本語|にほんご]を[勉強|べんきょう]する。"
    assert_equal expected, Furigana::Formatter::Text.format(Furigana::Parser.new.reading(text))
  end
end
