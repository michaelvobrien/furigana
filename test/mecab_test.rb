# -*- coding: utf-8 -*-
require 'test_helper'

class MecabTest < Test::Unit::TestCase
  test "chasen 食べる" do
    text = '食べる'
    expected = [{ element: "食べる", yomi: "タベル" }]
    assert_equal expected, Furigana::Mecab.chasen(text)
  end
  test "chasen alphanumeric with 食べる" do
    text = 'This is "食べる" 123'
    expected = [
      {:element=>"This", :yomi=>"This"},
      {:element=>"is", :yomi=>"is"},
      {:element=>"\"", :yomi=>"\""},
      {:element=>"食べる", :yomi=>"タベル"},
      {:element=>"\"", :yomi=>"\""},
      {:element=>"123", :yomi=>"123"}
    ]
    assert_equal expected, Furigana::Mecab.chasen(text)
  end
  test "paragraph" do
    text = <<-END
私は2年前に日本に移住しました。カメラで写真を撮りました。私は食べ物が好
きです。SNS１２３567。
END
    expected = [
      {:element=>"私", :yomi=>"ワタシ"},
      {:element=>"は", :yomi=>"ハ"},
      {:element=>"2", :yomi=>"2"},
      {:element=>"年", :yomi=>"ネン"},
      {:element=>"前", :yomi=>"マエ"},
      {:element=>"に", :yomi=>"ニ"},
      {:element=>"日本", :yomi=>"ニッポン"},
      {:element=>"に", :yomi=>"ニ"},
      {:element=>"移住", :yomi=>"イジュウ"},
      {:element=>"し", :yomi=>"シ"},
      {:element=>"まし", :yomi=>"マシ"},
      {:element=>"た", :yomi=>"タ"},
      {:element=>"。", :yomi=>"。"},
      {:element=>"カメラ", :yomi=>"カメラ"},
      {:element=>"で", :yomi=>"デ"},
      {:element=>"写真", :yomi=>"シャシン"},
      {:element=>"を", :yomi=>"ヲ"},
      {:element=>"撮り", :yomi=>"トリ"},
      {:element=>"まし", :yomi=>"マシ"},
      {:element=>"た", :yomi=>"タ"},
      {:element=>"。", :yomi=>"。"},
      {:element=>"私", :yomi=>"ワタシ"},
      {:element=>"は", :yomi=>"ハ"},
      {:element=>"食べ物", :yomi=>"タベモノ"},
      {:element=>"が", :yomi=>"ガ"},
      {:element=>"好き", :yomi=>"スキ"},
      {:element=>"です", :yomi=>"デス"},
      {:element=>"。", :yomi=>"。"},
      {:element=>"SNS", :yomi=>"SNS"},
      {:element=>"１", :yomi=>"イチ"},
      {:element=>"２３567", :yomi=>"２３567"},
      {:element=>"。", :yomi=>"。"}
    ]
    assert_equal expected, Furigana::Mecab.chasen(text)
  end
end
