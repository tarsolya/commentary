require File.dirname(__FILE__) + '/test_helper'

require 'rails'
require 'rails/generators'
require 'generators/commentary_generator'

class CommentaryGeneratorTest < Rails::Generators::TestCase
  tests CommentaryGenerator

  destination File.join(File.dirname(__FILE__), "rails_root", "tmp")
  setup :prepare_destination
  teardown :remove_destination


  def test_generate_commentary_files
    run_generator %w(commentary)
    assert_file File.join(base_path, "app/models", "comment.rb")
    assert_file File.join(base_path, "app/models", "comment_rating.rb")
    assert_file File.join(base_path, "db/migrate", "create_commentary.rb")
  end

  private

  def remove_destination
    FileUtils.rmdir(base_path)
  end

  def base_path
    File.join(File.dirname(__FILE__), "rails_root", "tmp")
  end

end
