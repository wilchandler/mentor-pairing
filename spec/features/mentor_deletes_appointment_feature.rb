require 'spec_helper'

feature "Mentor deletes appointment" do
  context "when the mentor deletes the appointment" do
    let(:appt) { FactoryGirl.create(:appointment) }

    it "removes the appointment from the database" do
      element_id = "delete_appointment_#{appt.id}"

      visit edit_user_path(id: appt.mentor.activation_code)

      click_on element_id

      expect(page).to have_content("The appointment was deleted!")
    end
  end
end
