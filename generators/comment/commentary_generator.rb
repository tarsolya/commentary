class CommentaryGenerator < Rails::Generator::Base
   def manifest
     record do |m|
       m.directory 'app/models'
       m.file 'comment.rb', 'app/models/comment.rb'
       m.file 'comment_ratings.rb', 'app/models/comment_ratings.rb'
       m.migration_template "create_commentary.rb", "db/migrate"
     end
   end
   # ick what a hack.
   def file_name
     "create_commentary"
   end
 end
