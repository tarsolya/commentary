module Commentary

  # including this module into your Comment model will give you finders and named scopes
  # useful for working with Comments.
  # The named scopes are:
  #   in_order: Returns comments in the order they were created (created_at ASC).
  #   recent: Returns comments by how recently they were created (created_at DESC).
  #   limit(N): Return no more than N comments.

  module Comment

    class InvalidRatingException < Exception; end

    def self.included(base)
      base.extend Finders

      base.named_scope :in_order, {:order => 'created_at ASC'}
      base.named_scope :recent, {:order => "created_at DESC"}
      base.named_scope :limit, lambda {|limit| {:limit => limit}}

      base.named_scope :only_positive, {:conditions => ["delta >= 0"]}
      base.named_scope :only_negative, {:conditions => ["delta < 0"]}

      base.named_scope :above_rating, lambda {|delta| {:conditions => ["delta > ?", delta]}}
      base.named_scope :below_rating, lambda {|delta| {:conditions => ["delta < ?", delta]}}
      base.named_scope :between_ratings, lambda {|min, max| {:conditions => ["delta > ? AND delta < ?", min, max]}}
    end

    module Finders

      # Helper class method to lookup all comments assigned
      # to all commentable types for a given user.
      def find_comments_by_user(user)
        find(:all,
          :conditions => ["user_id = ?", user.id],
          :order => "created_at DESC"
        )
      end

      # Helper class method to look up all comments for
      # commentable class name and commentable id.
      def find_comments_for_commentable(commentable_str, commentable_id)
        find(:all,
          :conditions => ["commentable_type = ? and commentable_id = ?", commentable_str, commentable_id],
          :order => "created_at DESC"
        )
      end

      # Helper class method to look up a commentable object
      # given the commentable class name and id
      def find_commentable(commentable_str, commentable_id)
        commentable_str.constantize.find(commentable_id)
      end

    end

    def reset!
      update_attributes({:likes => 0, :dislikes => 0})
    end

    def find_ratings_for_user(user_id)
      ratings.find(:all, :conditions => {:user_id => user_id})
    end

    def rating_count_for_user(user_id)
      ratings.count(:all, :conditions => {:user_id => user_id})
    end

    def positive_comment?
      delta > 0
    end

    def negative_comment?
      delta < 0
    end

    def neutral_comment?
      delta == 0
    end

    private

    def method_missing(name, *args, &block)
      if valid_rating_method?(name)
        params = extract_rating_params(name, args)
        create_rating(params)
      else
        super
      end
    end

    def extract_rating_params(*args)
      raise InvalidRatingException unless args[1][0].is_a?(Integer)
      {:vote  => args[0].to_s.delete("!"), :user_id => args[1][0]}
    end

    def valid_rating_method?(method)
      [:like!, :dislike!].include?(method)
    end

    def create_rating(params)
      unless !ActiveRecord::Base.commentary_options[:multivote] && rating_count_for_user(params[:user_id]) > 0
        ratings.create!(params)
        new_counts = {:likes => likes, :dislikes => dislikes}
        case params[:vote]
          when "like"
            new_counts[:likes] += 1
          when "dislike"
            new_counts[:dislikes] += 1
        end
        new_counts[:delta] = new_counts[:likes] - new_counts[:dislikes]
        update_attributes!(new_counts)
      end
    end

  end
end
