# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','furigana','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'furigana'
  s.version = Furigana::VERSION
  s.author = "Michael V. O'Brien"
  s.email = 'michael@michaelvobrien.com'
  s.homepage = 'https://github.com/michaelvobrien/furigana'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Add furigana to text'
  s.files = %w(
bin/furigana
lib/furigana.rb
lib/furigana/formatter/base.rb
lib/furigana/formatter/html.rb
lib/furigana/formatter/yomikata.rb
lib/furigana/formatter/json.rb
lib/furigana/formatter/text.rb
lib/furigana/formatters.rb
lib/furigana/cli.rb
lib/furigana/mecab.rb
lib/furigana/reader.rb
lib/furigana/version.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.rdoc_options << '--title' << 'furigana' << '-ri'
  s.bindir = 'bin'
  s.executables << 'furigana'

  s.add_runtime_dependency('diff-lcs')

  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('pry')
  s.add_development_dependency('pry-doc')
end
