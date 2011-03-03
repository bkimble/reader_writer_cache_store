# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{reader_writer_cache_store}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Billy Kimble"]
  s.date = %q{2011-03-02}
  s.description = %q{Reader/Writer Cache Store}
  s.email = %q{basslines@gmail.com}
  s.extra_rdoc_files = ["README", "README.rdoc", "lib/reader_writer_cache_store.rb", "lib/reader_writer_cache_store/active_support/cache/reader_writer_cache_store.rb"]
  s.files = ["Manifest", "README", "README.rdoc", "Rakefile", "lib/reader_writer_cache_store.rb", "lib/reader_writer_cache_store/active_support/cache/reader_writer_cache_store.rb", "reader_writer_cache_store.gemspec"]
  s.homepage = %q{https://github.com/bkimble}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Reader_writer_cache_store", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{reader_writer_cache_store}
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{Reader/Writer Cache Store}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
