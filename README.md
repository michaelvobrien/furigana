# Furigana

## Overview

Add furigana to text.

## Requirements

* Mecab (`brew install mecab mecab-ipadic`)

## Examples

```
  $ echo "私は日本語を勉強している。" | furigana
  私【わたし】は日本語【にほんご】を勉強【べんきょう】している。

  $ echo "私は日本語を勉強している。" | furigana --html
  <ruby><rb>私</rb><rp>【</rp><rt>わたし</rt><rp>】</rp></ruby>は<ruby><rb>日本語</rb><rp>【</rp><rt>にほんご</rt><rp>】</rp></ruby>を<ruby><rb>勉強</rb><rp>【</rp><rt>べんきょう</rt><rp>】</rp></ruby>している。
```
