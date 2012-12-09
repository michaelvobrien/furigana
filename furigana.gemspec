# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','furigana','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'furigana'
  s.version = Furigana::VERSION
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
# Add your other files here if you make them
  s.files = %w(
bin/furigana
lib/furigana/version.rb
lib/furigana.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','furigana.rdoc']
  s.rdoc_options << '--title' << 'furigana' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'furigana'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('diff-lcs')
  s.add_development_dependency('debugger')
  s.add_runtime_dependency('diff-lcs')
  s.add_runtime_dependency('redcarpet')
end
