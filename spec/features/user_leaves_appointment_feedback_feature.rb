require "spec_helper"

feature "User leaves Appointment Feedback" do
  context "when a user provides the proper code and appointment id" do
    let(:appointment) { FactoryGirl.create(:appointment) }
    let(:mentor) { appointment.mentor }
    let(:student) { appointment.mentee }

    it "informs the user who they are leaving feedback for" do
      visit new_appointment_feedback_path(mentor.activation_code,
                                          :appointment_id => appointment.id)
      page.should have_content("Leave Feedback for #{student.name}")
    end

    it "upon submission the user's feedback is saved" do
      visit new_appointment_feedback_path(mentor.activation_code,
                                          :appointment_id => appointment.id)

      fill_in "Feedback", :with => "Such and such was really great"

      expect {
        click_button "Submit Feedback"
      }.to change(AppointmentFeedback, :count).by(1)
    end
  end
end