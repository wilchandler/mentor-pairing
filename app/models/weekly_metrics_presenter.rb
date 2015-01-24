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
    appointments.count
  end

  def has_included_date?(date)
    (starting..ending).cover?(date)
  end

  def total_abandoned_availabilties
    availabilities.abandoned.count
  end

  def appointments_for(city)
    appointments.where(city: city).count
  end

  def abandoned_availabilities_for(city)
    availabilities.abandoned.where(city: city).count
  end

  protected

  def availabilities
    Availability.where(:start_time => (starting..ending))
  end

  def appointments
    Appointment.where(:start_time => (starting..ending))
  end
end
