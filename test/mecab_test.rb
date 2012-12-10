# -*- coding: utf-8 -*-
require 'test_helper'

class MecabTest < Test::Unit::TestCase
  test "chasen 食べる" do
    text = '食べる'
    expected = [{ element: "食べる", yomi: "たべる" }]
    assert_equal expected, Furigana::Mecab.chasen(text)
  end
end
