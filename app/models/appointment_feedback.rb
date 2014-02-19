class AppointmentFeedback < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :feedback_giver, :class_name => "User"
  belongs_to :feedback_receiver, :class_name => "User"
end