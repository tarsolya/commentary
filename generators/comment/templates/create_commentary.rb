class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :commentable, :polymorphic => true
      t.references :user
      t.string :title, :default => "" 
      t.text :body, :default => ""
      t.integer :likes, :dislikes, :default => 0
      t.timestamps
    end
    
    create_table :comment_ratings do |t|
      t.references :comment
      t.references :user
      t.references :vote, :default => "like"
      t.timestamps
    end
    
    add_index :comments, :commentable_type
    add_index :comments, :commentable_id
    add_index :comments, :user_id
    
    add_index :comment_ratings, :comment_id
    add_index :comment_ratings, :user_id
  end

  def self.down
    drop_table :comment_ratings
    drop_table :comments
  end
end
