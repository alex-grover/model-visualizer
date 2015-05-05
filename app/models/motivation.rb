class Motivation < ActiveRecord::Base
	belongs_to :user

  @@default_inspiration_str = [
    { select: 'false', option: 'Allow me to compete with similar patients' },
    { select: 'false', option: 'Help me track my own progress and successes' },
    { select: 'false', option: 'Allow me to virtually connect with patients similar to me' },
    { select: 'false', option: 'Pair me with a PT mentor, someone who has undergone this same rehab' },
    { select: 'false', option: 'Send me occasional educational emails with rehab tips' },
    { select: 'false', option: 'Let me post on social media about my progress' },
    { select: 'false', option: 'Allow me to share progress milestones with family and friends' },
  ].to_json

  @@default_goal_str = [
    { select: 'false', option: 'Daily Routine', type: 'Daily Activity' },
    { select: 'false', option: 'Walk', type: 'Daily Activity' },
    { select: 'false', option: 'Go Out', type: 'Daily Activity' },
    { select: 'false', option: 'Drive', type: 'Daily Activity' },
    { select: 'false', option: 'Play with Kids', type: 'Daily Activity' },
    { select: 'false', option: 'Work', type: 'Daily Activity' },
    { select: 'false', option: 'Running', type: 'Hobby' },
    { select: 'false', option: 'Yoga', type: 'Hobby' },
    { select: 'false', option: 'Gym Exercise', type: 'Hobby' },
    { select: 'false', option: 'Biking', type: 'Hobby' },
    { select: 'false', option: 'Swimming', type: 'Hobby' },
    { select: 'false', option: 'Golf', type: 'Hobby' },
    { select: 'false', option: 'Tennis', type: 'Hobby' },
    { select: 'false', option: 'Basketball', type: 'Hobby' },
    { select: 'false', option: 'Fishing', type: 'Hobby' }
  ].to_json

  def self.default_inspiration_str
    @@default_inspiration_str
  end

  def self.default_goal_str
    @@default_goal_str
  end

  def to_json
    {
      injury: injury,
      goal: JSON.parse(goal),
      inspiration: JSON.parse(inspiration)
    }
  end
end
