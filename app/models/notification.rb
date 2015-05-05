class Notification < ActiveRecord::Base
  has_many :users, through: :UserNotificationPair
end
