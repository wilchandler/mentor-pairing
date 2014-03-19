class MakesRecurringAvailabilities
  def initialize(mentor, availability_params)
    @mentor = mentor
    @availability_params = availability_params
  end

  def make_availabilities
    if setting_up_recurrence?
      @mentor.availabilities.create!(params_without_recurrence)

      number_of_recurrences.times do |i|
        recurred_availability = @mentor.availabilities.build(params_without_recurrence)
        recurred_availability.start_time += recurrence_factor * (i + 1)
        recurred_availability.save!
      end
    else
      @mentor.availabilities.create!(params_without_recurrence)
    end
  end

  def setting_up_recurrence?
    !@availability_params["setup_recurring"].blank? &&
      @availability_params["setup_recurring"] == "1"
  end

  def recurrence_factor
    base_factor = 7.days

    case @availability_params["recur_weekly"]
    when "1"
      base_factor
    when "2"
      base_factor * 2
    when "4"
      base_factor * 4
    else
      raise "Invalid recurrence factor"
    end
  end

  def number_of_recurrences
    @availability_params["recur_num"].to_i
  end

  private

  def params_without_recurrence
    @availability_params.except(*recurrence_params)
  end

  def recurrence_params
    ["setup_recurring", "recur_weekly", "recur_num"]
  end
end