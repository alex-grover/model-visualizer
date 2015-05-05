class Feedback < ActiveRecord::Base
  belongs_to :user

  def to_api_json
    {
      "date" => date.to_s,
      "rating" => rating,
      "message" => message
    }
  end
end
