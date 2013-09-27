class UsersController < ApplicationController
  def edit
    @user = User.find_by_activation_code(params[:id])
    @availabilities = @user.availabilities.visible.order(:start_time)
    @menteeing_appointments = @user.menteeing_appointments.order(:start_time)
    @mentoring_appointments = @user.mentoring_appointments.order(:start_time)
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end
end
