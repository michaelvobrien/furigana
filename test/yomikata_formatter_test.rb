# -*- coding: utf-8 -*-
require 'test_helper'

class YomikataFormatterTest < Test::Unit::TestCase
  test "食べる" do
    text = "食べる"
    expected = "たべる"
    assert_equal expected, Furigana::Formatter::Yomikata.format(text, Furigana::Reader.new.reading(text))
  end
  test "勉強" do
    text = "勉強"
    expected = "べんきょう"
    assert_equal expected, Furigana::Formatter::Yomikata.format(text, Furigana::Reader.new.reading(text))
  end
  test "細かいお金" do
    text = "細かいお金"
    expected = "こまかいおかね"
    assert_equal expected, Furigana::Formatter::Yomikata.format(text, Furigana::Reader.new.reading(text))
  end
  test "日本語を勉強する。" do
    text = "日本語を勉強する。"
    expected = "にほんごをべんきょうする。"
    assert_equal expected, Furigana::Formatter::Yomikata.format(text, Furigana::Reader.new.reading(text))
  end
  test "バルト海の新しい読み物。" do
    text = "バルト海の新しい読み物。"
    expected = "ばるとかいのあたらしいよみもの。"
    assert_equal expected, Furigana::Formatter::Yomikata.format(text, Furigana::Reader.new.reading(text))
  end
  test "これはカタカナです。" do
    text = "これはカタカナです。"
    expected = "これはかたかなです。"
    assert_equal expected, Furigana::Formatter::Yomikata.format(text, Furigana::Reader.new.reading(text))
  end
  test "no kanji" do
    text = "no kanji"
    expected = "no kanji"
    assert_equal expected, Furigana::Formatter::Yomikata.format(text, Furigana::Reader.new.reading(text))
  end
  test "国営通信は２０日" do
    text = "国営通信は２０日"
    expected = "こくえいつうしんは２０にち"
    assert_equal expected, Furigana::Formatter::Yomikata.format(text, Furigana::Reader.new.reading(text))
  end
end
