module Commentary

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