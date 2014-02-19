FactoryGirl.define do
  factory :appointment_feedback do
    appointment { FactoryGirl.create(:appointment) }
    feedback_giver { appointment.mentor }
    feedback_receiver { appointment.mentee }
    text Faker::Lorem.paragraph
  end
end
