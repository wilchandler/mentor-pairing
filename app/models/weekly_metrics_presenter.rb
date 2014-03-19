class WeeklyMetricsPresenter
  def initialize(for_week_of = nil)
    @for_week_of = for_week_of
  end

  def for_week_of
    if @for_week_of
      Time.parse(@for_week_of)
    else
      Time.now
    end
  end

  def starting
    for_week_of.beginning_of_week(:sunday)
  end

  def ending
    for_week_of.end_of_week(:sunday)
  end

  def total_appointments
    Appointment.where(:start_time => (starting..ending)).count
  end

  def has_included_date?(date)
    (starting..ending).cover?(date)
  end

  def total_abandoned_availabilties
    Availability.abandoned.where(:start_time => (starting..ending)).count
  end
end