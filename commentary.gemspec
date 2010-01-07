# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{commentary}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["András Tarsoly"]
  s.autorequire = %q{commentary}
  s.date = %q{2010-01-07}
  s.description = %q{Provides commenting functionality for ActiveRecord models, with like / dislike and filtering capabilities.}
  s.email = %q{andras.tarsoly@xpnindustries.com}
  s.extra_rdoc_files = ["README", "MIT-LICENSE"]
  s.files = ["MIT-LICENSE", "README", "generators/comment", "generators/comment/comment_generator.rb", "generators/comment/templates", "generators/comment/templates/comment.rb", "generators/comment/templates/create_comments.rb", "lib/acts_as_commentable.rb", "lib/comment_methods.rb", "lib/commentable_methods.rb", "tasks/acts_as_commentable_tasks.rake", "init.rb", "install.rb"]
  s.homepage = %q{http://xpnindustries.com/projects/commentary}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Provides commenting functionality for ActiveRecord models, with like / dislike and filtering capabilities.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
