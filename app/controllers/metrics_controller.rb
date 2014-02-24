class MetricsController < ApplicationController
  def weekly
    @range = (Time.now.beginning_of_week(:sunday)..Time.now.end_of_week(:sunday))
    @total_appointments_count = Appointment.where(:start_time => @range).count
  end
end