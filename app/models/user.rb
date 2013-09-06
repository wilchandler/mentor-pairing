class User < ActiveRecord::Base
  attr_accessible :email, :name, :type, :twitter_handle, :provider, :provider_id

  has_many :availabilities, :foreign_key => :mentor_id
  has_many :mentoring_appointments, :foreign_key => :mentor_id, :class_name => "Appointment"
  has_many :menteeing_appointments, :foreign_key => :mentee_id, :class_name => "Appointment"
  validates :provider, :provider_id, presence: true

  before_create :create_activation_code

  def send_activation
    UserMailer.user_activation(self).deliver
    self
  end

  def send_appointment_request(availability)
    UserMailer.appointment_request(availability, self).deliver
  end

  def send_appointment_confirmation(appointment)
    UserMailer.appointment_confirmation(appointment).deliver
  end

  private

  def create_activation_code
    self.activation_code = Digest::MD5.hexdigest(rand.to_s + Time.now.to_s + (twitter_handle || ""))
  end
end
