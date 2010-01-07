class Comment < ActiveRecord::Base

  include Commentary::Comment

  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

end
