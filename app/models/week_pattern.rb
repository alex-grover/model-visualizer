class WeekPattern < ActiveRecord::Base
  belongs_to :protocol
  belongs_to :exercise
end
