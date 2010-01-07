module Commentary
  # including this module into your Comment model will give you finders and named scopes
  # useful for working with Comments.
  # The named scopes are:
  #   in_order: Returns comments in the order they were created (created_at ASC).
  #   recent: Returns comments by how recently they were created (created_at DESC).
  #   limit(N): Return no more than N comments.
  module Rating
    
    def self.included(comment_model)
      comment_model.extend Finders
      comment_model.named_scope :in_order, {:order => 'created_at ASC'}
      comment_model.named_scope :recent, {:order => "created_at DESC"}
      comment_model.named_scope :limit, lambda {|limit| {:limit => limit}}
    end
    
    module Finders
    end
    
  end
end