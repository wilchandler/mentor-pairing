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
    
    expect(page).to have_content("10 appointments this week")
  end

  scenario "display the metrics for the week of an arbitrary date" do
    previous_date = 2.weeks.ago
    prev_week_begin = previous_date.beginning_of_week(:sunday)

    visit weekly_metrics_path(:for => previous_date.strftime("%Y%m%d"))

    expect(page).to have_content("Metrics for the week of #{prev_week_begin.strftime("%Y-%m-%d")}")
  end

  scenario "displays link for last week's metrics" do
    last_week = 1.week.ago

    visit weekly_metrics_path

    expect(page).to have_link(nil, :href => weekly_metrics_path(:for => last_week.strftime("%Y%m%d")))
  end

  scenario "displays link for current week's metrics if on other week" do
    previous_date = 2.weeks.ago
    prev_week_begin = previous_date.beginning_of_week(:sunday)

    visit weekly_metrics_path(:for => previous_date.strftime("%Y%m%d"))

    expect(page).to have_link(nil, :href => weekly_metrics_path)
  end
end