require 'spec_helper'

describe AppointmentsController do
  describe "#create" do
    it "creates a new appointment" do
      availability = FactoryGirl.create(:availability)
      mentor = availability.mentor
      mentee = FactoryGirl.create(:mentee)

      expect {
        post :create, code: mentor.activation_code, mentee_id: mentee.id, availability_id: availability.id
      }.to change{Appointment.count}.by(1)
    end

    it "sends emails to accepted and rejected mentees" do
      availability = FactoryGirl.create(:availability)
      mentor = availability.mentor
      mentee = FactoryGirl.create(:mentee)
      other_mentee = FactoryGirl.create(:user)

      availability.appointment_requests.create!(:mentee => mentee)
      availability.appointment_requests.create!(:mentee => other_mentee)

      UserMailer.should_receive(:appointment_confirmation).and_return(double(:deliver => true))
      UserMailer.should_receive(:appointment_rejection).with(availability, other_mentee).and_return(double(:deliver => true))

      post :create, code: mentor.activation_code, mentee_id: mentee.id, availability_id: availability.id
    end

    it "does not create a new appointment if availability no longer exists" do
      mentor = FactoryGirl.create(:mentor)
      mentee = FactoryGirl.create(:mentee)

      expect {
        post :create, code: mentor.activation_code, mentee_id: mentee.id, availability_id: "42"*4
      }.not_to change{Appointment.count}
    end
  end

  describe "#destroy" do
    let!(:availability) { FactoryGirl.create(:availability) }
    let!(:mentor) { availability.mentor }
    let!(:mentee) { FactoryGirl.create(:mentee) }
    let!(:appointment) { Appointment.create!(mentor: mentor, mentee: mentee, availability: availability) }

    it 'does not destroy an appointment if the wrong mentor' do
      other_mentor = FactoryGirl.create(:mentor)

      expect {
        post(:destroy, code: other_mentor.activation_code, id: appointment.id)
      }.not_to change { Appointment.count }
    end
    
    it 'destroys an appointment if the mentor is correct' do
      expect {
        post(:destroy, code: mentor.activation_code, id: appointment.id)
      }.to change { Appointment.count }.by -1
    end
  end
end
