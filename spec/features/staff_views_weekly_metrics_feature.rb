require "spec_helper"

feature "Staff Views Weekly Metrics" do
  scenario "displays the total number of appointments this week" do
    10.times {
      availability = FactoryGirl.create(:availability,
                      :start_time => rand(Time.now.beginning_of_week(:sunday)..Time.now.end_of_week(:sunday)),
                      :duration => 60)
      FactoryGirl.create(:appointment, :availability => availability)
    }
    
    visit weekly_metrics_path
    
    page.should have_content("10 appointments this week")
  end
end