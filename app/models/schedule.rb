class Schedule < ActiveRecord::Base
	belongs_to :prescription
  belongs_to :user

  def self.apply_schedules(schedules)
    exercise_list = []
    schedules.map do |s|
      num_sets = s.prescription.sets
      num_sets.times.each { exercise_list << s.to_exercise_hash }
    end
    exercise_list.shuffle()
  end

  def self.to_exercise_list
    all.map do |s|
      s.to_exercise_hash
    end
  end

  #TODO: remove exercise_name, and just use p.exercise.name
  def to_exercise_hash
    p = prescription
    {
      'exercise' => p.exercise_name,
      'img_url' => p.exercise.img_url,
      'video_url' => p.exercise.video_url,
      'instruction' => p.exercise.instruction,
      'hold' => p.hold,
      'duration' => p.duration,
      'reps' => p.reps,
      'sets' => p.sets,
      'time_per_set' => p.time_per_set
    }
  end
end
