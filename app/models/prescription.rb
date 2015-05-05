class Prescription < ActiveRecord::Base
  belongs_to :user
  belongs_to :therapist
  belongs_to :exercise

  has_many :schedules, dependent: :destroy

  validates :therapist_id, :user_id, :exercise_id, :exercise_name, presence: true
  validates :start_date, :num_week, :end_date, :frequency, presence: true

  def auto_schedule
    puts "start auto scheduling..."
    # don't forget to set is_scheduled field to true
    # currently we only have naive version with no random-scheduling for even
    case frequency
      when 0
        schedule_1x
      when 1
        schedule_2x
      when 2
        schedule_3x
      when 3
        schedule_4x
      when 4
        schedule_5x
      when 5
        schedule_6x
      when 6
        schedule_7x
    end
    self.update_attribute('is_scheduled', true)
  end

  def schedule_1x
    seed = get_start_seed(7)
    (1..num_week).each do |i|
      Schedule.create(date: start_date + seed +  (i-1)*7, prescription_id: id, user_id: user_id)
    end
  end

  def schedule_2x
    seed = get_start_seed(5)
    (1..num_week).each do |i|
      Schedule.create(date: start_date + seed + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 4 + (i-1)*7, prescription_id: id, user_id: user_id)
    end
  end

  def schedule_3x
    seed = get_start_seed(4)
    (1..num_week).each do |i|
      Schedule.create(date: start_date + seed + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 2 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 4 + (i-1)*7, prescription_id: id, user_id: user_id)
    end
  end

  def schedule_4x
    seed = get_start_seed(3)
    (1..num_week).each do |i|
      Schedule.create(date: start_date + seed + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 2 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 4 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 6 + (i-1)*7, prescription_id: id, user_id: user_id)
    end
  end

  def schedule_5x
    seed = get_start_seed(3)
    (1..num_week).each do |i|
      Schedule.create(date: start_date + seed + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 2 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 3 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 5 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 6 + (i-1)*7, prescription_id: id, user_id: user_id)
    end
  end

  def schedule_6x
    seed = get_start_seed(2)
    (1..num_week).each do |i|
      Schedule.create(date: start_date + seed + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 2 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 3 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 4 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 5 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 6 + (i-1)*7, prescription_id: id, user_id: user_id)
    end
  end

  def schedule_7x
    seed = 0
    (1..num_week).each do |i|
      Schedule.create(date: start_date + seed + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 1 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 2 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 3 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 4 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 5 + (i-1)*7, prescription_id: id, user_id: user_id)
      Schedule.create(date: start_date + seed + 6 + (i-1)*7, prescription_id: id, user_id: user_id)
    end
  end

  private

  def get_start_seed(hint)
    schedule = Schedule.where(start_date: start_date, user_id: user_id)
    if schedule
      rand(hint)
    else
      0
    end
  end
end
