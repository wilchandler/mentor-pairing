class Appointment < ActiveRecord::Base
  include LocaltimeAdjustment

  attr_accessor :availability

  belongs_to :mentor, :class_name => "User"
  belongs_to :mentee, :class_name => "User"
  has_many :kudos

  validates :mentor_id, :presence => true
  validates :mentee, :presence => true

  before_create :parse_availability
  after_create :kill_availability, :create_kudo

  scope :visible, Proc.new {
    where("end_time > ?", Time.now)
  }

  scope :past, Proc.new {
    where("end_time < ?", Time.now)
  }

  scope :recently_ended, -> { where(:end_time => (1.hour.ago..Time.now)) }
  scope :feedback_not_sent, -> { where(:feedback_sent => false) }
  scope :ready_for_feedback, -> { recently_ended.feedback_not_sent }

  def self.find_by_id_and_user(appointment_id, user)
    appointment_arel = Appointment.arel_table
    Appointment.where(:id => appointment_id).
                where(
                  appointment_arel[:mentor_id].eq(user.id).
                  or(appointment_arel[:mentee_id].eq(user.id))
                ).first
  end

  private

  def parse_availability
    self.start_time = availability.start_time
    self.end_time   = availability.end_time
    self.timezone   = availability.timezone
    self.location   = availability.location
    self.city       = availability.city
  end

  def kill_availability
    availability.destroy
  end

  def create_kudo
    self.kudos.create(mentor_id: self.mentor.id, mentee_id: self.mentee_id)
  end
end
