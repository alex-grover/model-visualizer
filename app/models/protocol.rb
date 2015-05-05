class Protocol < ActiveRecord::Base
  has_many :week_patterns, :dependent => :destroy
  has_many :exercises, :through => :week_patterns
end
