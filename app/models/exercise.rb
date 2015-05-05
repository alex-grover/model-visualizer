class Exercise < ActiveRecord::Base
	has_many :schedules
  has_many :prescriptions
  has_many :week_patterns, :dependent => :destroy
  has_many :protocols, :through => :week_patterns

  def self.to_api_json
    all.each.map do |e|
      {
        "name" => e.name,
        "instruction" => e.instruction,
        "img_url" => e.img_url,
        "video_url" => e.video_url
      }
    end
  end
end
