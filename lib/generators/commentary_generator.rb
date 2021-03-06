class CommentaryGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)

  def generate_commentary
    template 'comment.rb', File.join('app/models', 'comment.rb')
    template 'comment_rating.rb', File.join('app/models', 'comment_rating.rb')
    migration_template 'create_commentary.rb', File.join("db/migrate", "create_commentary.rb")
  end

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

end
