# -*- coding: utf-8 -*-
require 'test_helper'

class MecabTest < Test::Unit::TestCase
  test "chasen 食べる" do
    text = '食べる'
    expected = [{ element: "食べる", yomi: "たべる" }]
    assert_equal expected, Furigana::Mecab.chasen(text)
  end
  test "chasen alphanumeric with 食べる" do
    text = 'This is "食べる" 123'
    expected = [
      {:element=>"This", :yomi=>"This"},
      {:element=>"is", :yomi=>"is"},
      {:element=>'"', :yomi=>'"'},
      {:element=>"食べる", :yomi=>"たべる"},
      {:element=>'"', :yomi=>'"'},
      {:element=>'123', :yomi=>'123'}
    ]
    assert_equal expected, Furigana::Mecab.chasen(text)
  end
  test "paragraph" do
    text = <<-END
私は2年前に日本に移住しました。カメラで写真を撮りました。私は食べ物が好
きです。SNS１２３567。
END
    expected = [{:element=>"私", :yomi=>"わたし"},
      {:element=>"は", :yomi=>"は"},
      {:element=>"2", :yomi=>"2"},
      {:element=>"年", :yomi=>"ねん"},
      {:element=>"前", :yomi=>"まえ"},
      {:element=>"に", :yomi=>"に"},
      {:element=>"日本", :yomi=>"にっぽん"},
      {:element=>"に", :yomi=>"に"},
      {:element=>"移住", :yomi=>"いじゅう"},
      {:element=>"し", :yomi=>"し"},
      {:element=>"まし", :yomi=>"まし"},
      {:element=>"た", :yomi=>"た"},
      {:element=>"。", :yomi=>"。"},
      {:element=>"カメラ", :yomi=>"カメラ"},
      {:element=>"で", :yomi=>"で"},
      {:element=>"写真", :yomi=>"しゃしん"},
      {:element=>"を", :yomi=>"を"},
      {:element=>"撮り", :yomi=>"とり"},
      {:element=>"まし", :yomi=>"まし"},
      {:element=>"た", :yomi=>"た"},
      {:element=>"。", :yomi=>"。"},
      {:element=>"私", :yomi=>"わたし"},
      {:element=>"は", :yomi=>"は"},
      {:element=>"食べ物", :yomi=>"たべもの"},
      {:element=>"が", :yomi=>"が"},
      {:element=>"好き", :yomi=>"すき"},
      {:element=>"です", :yomi=>"です"},
      {:element=>"。", :yomi=>"。"},
      {:element=>"SNS", :yomi=>"SNS"},
      {:element=>"１", :yomi=>"いち"},
      {:element=>"２３567", :yomi=>"２３567"},
      {:element=>"。", :yomi=>"。"}]
    assert_equal expected, Furigana::Mecab.chasen(text)
  end
end
