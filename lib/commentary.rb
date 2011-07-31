# Commentary
#
require 'active_record'
require 'commentable_methods'
require 'comment_methods'
require 'rating_methods'

module XPN
  module Commentary

    # Def. options for Commentary
    DEFAULT_OPTIONS = {
      :multivote => false,
      :valid_method_names => [:like!, :dislike!]
    }.freeze

    def has_commentary(*args)
      self.commentary_options.merge!(args.extract_options!)
      has_many :comments, :as => :commentable, :dependent => :destroy
      include XPN::Commentary::Commentable::InstanceMethods
      extend XPN::Commentary::Commentable::SingletonMethods
    end

    attr_writer :commentary_options
    def commentary_options
      @commentary_options ||= {}.merge(XPN::Commentary::DEFAULT_OPTIONS)
    end

  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend XPN::Commentary
  ActiveRecord::Base.send :include, XPN::Commentary
end

