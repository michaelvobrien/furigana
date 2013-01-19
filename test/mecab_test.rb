# -*- coding: utf-8 -*-
require 'test_helper'

class MecabTest < Test::Unit::TestCase
  test "tokenize 食べる" do
    text = '食べる'
    expected = [{ surface_form: "食べる", reading: "タベル" }]
    assert_equal expected, Furigana::Mecab.tokenize(text)
  end
  test "tokenize alphanumeric with 食べる" do
    text = 'This is "食べる" 123'
    expected = [
      {:surface_form => "This", :reading => "This"},
      {:surface_form => "is", :reading => "is"},
      {:surface_form => "\"", :reading => "\""},
      {:surface_form => "食べる", :reading => "タベル"},
      {:surface_form => "\"", :reading => "\""},
      {:surface_form => "123", :reading => "123"}
    ]
    assert_equal expected, Furigana::Mecab.tokenize(text)
  end
  test "paragraph" do
    text = <<-END
私は2年前に日本に移住しました。カメラで写真を撮りました。私は食べ物が好
きです。SNS１２３567。
END
    expected = [
      {:surface_form => "私", :reading => "ワタシ"},
      {:surface_form => "は", :reading => "ハ"},
      {:surface_form => "2", :reading => "2"},
      {:surface_form => "年", :reading => "ネン"},
      {:surface_form => "前", :reading => "マエ"},
      {:surface_form => "に", :reading => "ニ"},
      {:surface_form => "日本", :reading => "ニッポン"},
      {:surface_form => "に", :reading => "ニ"},
      {:surface_form => "移住", :reading => "イジュウ"},
      {:surface_form => "し", :reading => "シ"},
      {:surface_form => "まし", :reading => "マシ"},
      {:surface_form => "た", :reading => "タ"},
      {:surface_form => "。", :reading => "。"},
      {:surface_form => "カメラ", :reading => "カメラ"},
      {:surface_form => "で", :reading => "デ"},
      {:surface_form => "写真", :reading => "シャシン"},
      {:surface_form => "を", :reading => "ヲ"},
      {:surface_form => "撮り", :reading => "トリ"},
      {:surface_form => "まし", :reading => "マシ"},
      {:surface_form => "た", :reading => "タ"},
      {:surface_form => "。", :reading => "。"},
      {:surface_form => "私", :reading => "ワタシ"},
      {:surface_form => "は", :reading => "ハ"},
      {:surface_form => "食べ物", :reading => "タベモノ"},
      {:surface_form => "が", :reading => "ガ"},
      {:surface_form => "好き", :reading => "スキ"},
      {:surface_form => "です", :reading => "デス"},
      {:surface_form => "。", :reading => "。"},
      {:surface_form => "SNS", :reading => "SNS"},
      {:surface_form => "１", :reading => "イチ"},
      {:surface_form => "２３567", :reading => "２３567"},
      {:surface_form => "。", :reading => "。"}
    ]
    assert_equal expected, Furigana::Mecab.tokenize(text)
  end
end
