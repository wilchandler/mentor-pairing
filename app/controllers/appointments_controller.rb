class AppointmentsController < ApplicationController
  def create
    mentee = User.find(params[:mentee_id])
    mentor = User.find_by_activation_code(params[:code])
    availability = mentor.availabilities.find_by_id(params[:availability_id])

    if availability
      AppointmentFactory.create!(availability, mentee, mentor)
      flash[:notice] = "An appointment has been created for you and #{mentee.name}. Enjoy!"
    else
      flash[:notice] = "This time is no longer available. Please create more mentoring availability."
    end

    redirect_to edit_user_path(mentor.activation_code)
  end
end
