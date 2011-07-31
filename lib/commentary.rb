# Commentary
#
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

    attr_accessor_with_default(:commentary_options, {}.merge(XPN::Commentary::DEFAULT_OPTIONS))

    def has_commentary(*args)
      self.commentary_options.merge!(args.extract_options!)
      has_many :comments, :as => :commentable, :dependent => :destroy
      include XPN::Commentary::Commentable::InstanceMethods
      extend XPN::Commentary::Commentable::SingletonMethods
    end

  end
end

ActiveRecord::Base.send(:extend, XPN::Commentary)

