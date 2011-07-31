class CommentRating < ActiveRecord::Base

  include Commentary::Rating

  belongs_to :user
  belongs_to :comment

  default_scope :order => 'created_at DESC'

end

