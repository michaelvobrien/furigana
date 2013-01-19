# -*- coding: utf-8 -*-
require 'test_helper'

class ReaderTest < Test::Unit::TestCase
  test "食べる" do
    text = "食べる"
    expected = [['食', 'た']]
    assert_equal expected, Furigana::Reader.new.reading(text)
  end
  test "勉強" do
    text = "勉強"
    expected = [['勉強', 'べんきょう']]
    assert_equal expected, Furigana::Reader.new.reading(text)
  end
  test "細かいお金" do
    text = "細かいお金"
    expected = [["細", "こま"], ["金", "かね"]]
    assert_equal expected, Furigana::Reader.new.reading(text)
  end
  test "コーヒーを飲んだ" do
    text = "コーヒーを飲んだ"
    expected = [["飲", "の"]]
    assert_equal expected, Furigana::Reader.new.reading(text)
  end
  test "日本語を勉強する。" do
    text = "日本語を勉強する。"
    expected = [['日本語', 'にほんご'], ['勉強', 'べんきょう']]
    assert_equal expected, Furigana::Reader.new.reading(text)
  end
  test "バルト海の新しい読み物。" do
    text = "バルト海の新しい読み物。"
    expected = [["海", "かい"], ["新", "あたら"], ["読", "よ"], ["物", "もの"]]
    assert_equal expected, Furigana::Reader.new.reading(text)
  end
end
