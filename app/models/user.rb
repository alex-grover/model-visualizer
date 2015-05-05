class User < ActiveRecord::Base
  # no validations included, but feel free to add your own
  # validates_presence_of :username
  devise :database_authenticatable, :registerable, :confirmable, :async,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  belongs_to :group

  has_one :motivation, dependent: :destroy
  has_one :notification_setting, dependent: :destroy

  has_many :schedules
  has_many :prescriptions
  has_many :feedbacks
  has_many :accomplishments
  has_many :schedule_logs

  has_many :notifications, through: :UserNotificationPair
  has_and_belongs_to_many :friends
  has_and_belongs_to_many :milestones
  has_and_belongs_to_many :therapists

  def update_daily_schedule
    schedule_logs = ScheduleLog.where("date >= ? AND user_id = ?", Date.today(timezone), id).presence
    if schedule_logs
      schedule_logs.each do |sl|
        schedules = Schedule.where(user_id: id, date: sl.date)
        exercise_list = Schedule.apply_schedules(schedules)
        sl.update!(schedules_json: exercise_list.to_json)
      end
    end
  end

  def init_other_fields
    update!(
      patient_id: (0..8).map{rand(10)}.join,
      profile_img: 'http://files.parsetfss.com/5e9f5db5-3197-4f88-824b-d374a4a032ec/tfss-3b815742-1c7d-4b7f-93b3-50ca49469d4c-foot.png',
      group_id: 1
    )
    create_notification_setting
    create_motivation(inspiration: Motivation.default_inspiration_str, goal: Motivation.default_goal_str)
  end

  def full_name
    first_name.capitalize + ' ' + last_name.capitalize
  end

  class ParameterSanitizer < Devise::ParameterSanitizer
    def sign_up
      default_params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end
end