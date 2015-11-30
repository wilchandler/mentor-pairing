require 'spec_helper'

feature "Mentor creates availability" do
  context "when the mentor provides valid input" do
    it "persists the availability to the database" do
      mentor = FactoryGirl.create(:mentor)

      visit new_availability_path
      fill_in :first_name, with: mentor.first_name
      fill_in :last_name, with: mentor.last_name
      fill_in :email, with: mentor.email
      fill_in :twitter_handle, with: mentor.twitter_handle
      fill_in :availability_duration, with: 60


      mentoring_time = 1.week.from_now.change(:hour => 18, :min => 45).beginning_of_minute
      select_datetime(mentoring_time, :availability_start_time)

      click_on :submit_availability

      expect(page).to have_content "#{mentor.name} on #{mentoring_time.strftime("%m/%d/%Y")} from 6:45pm"
    end
  end

  context "when displaying the availabity request" do
    it "displays the user's full name" do
      availability = FactoryGirl.create(:availability)
      visit "/"

      avail_panel = find_link(availability.mentor.name).find(:xpath, "ancestor::div[@class='panel']")
      within(avail_panel) do
        click_link "Sign up"
      end

      expect(page).to have_text(availability.mentor.name)
    end
  end

  context "when the mentor provides recurrence parameters" do
    it "persists the availabilities to the database" do
      mentor = FactoryGirl.create(:mentor)

      visit new_availability_path
      fill_in :first_name, with: mentor.first_name
      fill_in :last_name, with: mentor.last_name
      fill_in :email, with: mentor.email
      fill_in :twitter_handle, with: mentor.twitter_handle
      fill_in :availability_duration, with: 60

      mentoring_time = 1.week.from_now
      select_datetime(mentoring_time, :availability_start_time)
      check :availability_setup_recurring
      select("week", :from => :availability_recur_weekly)
      select("1", :from => :availability_recur_num)

      expect {
        click_on :submit_availability
      }.to change(Availability, :count).by(2)
    end

    it "all availabilities are viewable by mentor" do
      mentor = FactoryGirl.create(:mentor)

      visit new_availability_path
      fill_in :first_name, with: mentor.first_name
      fill_in :last_name, with: mentor.last_name
      fill_in :email, with: mentor.email
      fill_in :twitter_handle, with: mentor.twitter_handle
      fill_in :availability_duration, with: 60

      mentoring_time = 1.week.from_now.change(:hour => 12, :min => 45).beginning_of_minute
      second_time = mentoring_time + 7.days
      select_datetime(mentoring_time, :availability_start_time)
      check :availability_setup_recurring
      select("week", :from => :availability_recur_weekly)
      select("1", :from => :availability_recur_num)

      click_on :submit_availability

      expect(page).to have_content "#{mentor.name} on #{mentoring_time.strftime("%m/%d/%Y")} from 12:45pm"
      expect(page).to have_content "#{mentor.name} on #{second_time.strftime("%m/%d/%Y")} from 12:45pm"
    end

    it 'displays a preview of the recurring appointment dates', js: true do
      mentor = FactoryGirl.create(:mentor)

      visit new_availability_path
      fill_in :first_name, with: mentor.first_name
      fill_in :last_name, with: mentor.last_name
      fill_in :email, with: mentor.email
      fill_in :twitter_handle, with: mentor.twitter_handle
      fill_in :availability_duration, with: 60

      mentoring_time = 1.week.from_now
      select_datetime(mentoring_time, :availability_start_time)
      check :availability_setup_recurring
      select('week', :from => :availability_recur_weekly)

      num_recurrences = 3
      dates = (0..num_recurrences).to_a.map { |n| mentoring_time + n.weeks }
      select(num_recurrences.to_s, :from => :availability_recur_num)

      dates_preview = page.find('.dates_recurring').text
      dates_formatted = dates.map { |d| d.strftime('%-m/%-d') }.to_sentence

      time_preview = page.find('.time_recurring').text
      minutes = round_availability_minutes(mentoring_time.min)
      adjusted_time = mentoring_time.change(min: minutes)
      time_formatted = adjusted_time.strftime('%I:%M %P') # => Example: '06:45 pm'

      expect(dates_preview).to match dates_formatted
      expect(time_preview).to match time_formatted
    end
  end
end
