# -*- coding: utf-8 -*-
require 'test_helper'

class TextFormatterTest < Test::Unit::TestCase
  test "食べる" do
    text = "食べる"
    expected = "食【た】べる"
    assert_equal expected, Furigana::Formatter::Text.new(text, Furigana::Reader.new.reading(text)).render
  end
  test "勉強" do
    text = "勉強"
    expected = "勉強【べんきょう】"
    assert_equal expected, Furigana::Formatter::Text.new(text, Furigana::Reader.new.reading(text)).render
  end
  test "細かいお金" do
    text = "細かいお金"
    expected = "細【こま】かいお金【かね】"
    assert_equal expected, Furigana::Formatter::Text.new(text, Furigana::Reader.new.reading(text)).render
  end
  test "日本語を勉強する。" do
    text = "日本語を勉強する。"
    expected = "日本語【にほんご】を勉強【べんきょう】する。"
    assert_equal expected, Furigana::Formatter::Text.new(text, Furigana::Reader.new.reading(text)).render
  end
  test "バルト海の新しい読み物。" do
    text = "バルト海の新しい読み物。"
    expected = "バルト海【かい】の新【あたら】しい読【よ】み物【もの】。"
    assert_equal expected, Furigana::Formatter::Text.new(text, Furigana::Reader.new.reading(text)).render
  end
  test "これはカタカナです。" do
    text = "これはカタカナです。"
    expected = "これはカタカナです。"
    assert_equal expected, Furigana::Formatter::Text.new(text, Furigana::Reader.new.reading(text)).render
  end
  test "no kanji" do
    text = "no kanji"
    expected = "no kanji"
    assert_equal expected, Furigana::Formatter::Text.new(text, Furigana::Reader.new.reading(text)).render
  end
  test "国営通信は２０日" do
    text = "国営通信は２０日"
    expected = "国営【こくえい】通信【つうしん】は２０日【にち】"
    assert_equal expected, Furigana::Formatter::Text.new(text, Furigana::Reader.new.reading(text)).render
  end
end
