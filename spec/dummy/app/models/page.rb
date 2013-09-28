class Page < ActiveRecord::Base
  attr_accessible :content, :title

  acts_as_metatags
end
