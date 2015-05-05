class Milestone < ActiveRecord::Base
  has_and_belongs_to_many :users

  # weird: cannot use self.to_json, it's somehow overridden by default to_json methods
  def self.to_api_json
    all.group_by(&:goal).map do |goal, milestone|
      {
        "goal" => goal,
        "milestones" => milestone.map { |m| {"title" => m.milestone, "description" => 'some description here'} }
      }
    end
  end
end
