class Accomplishment < ActiveRecord::Base
  belongs_to :user

  scope :acc_insofar, -> (user, time) do
    select("date, sum(minutes) AS minutes, max(acc) AS acc")
      .where("user_id = ? AND date <= ?", user.id, time)
      .group(:date)
  end

  def to_api_json
    {
      "date" => date.to_s,
      "today" => minutes,
      "accumulate" => acc
    }
  end
end
