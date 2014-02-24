class MetricsController < ApplicationController
  def weekly
    @for_week_of = params[:for] ? Time.parse(params[:for]) : Time.now
    @range = (@for_week_of.beginning_of_week(:sunday)..@for_week_of.end_of_week(:sunday))
    @total_appointments_count = Appointment.where(:start_time => @range).count
  end
end