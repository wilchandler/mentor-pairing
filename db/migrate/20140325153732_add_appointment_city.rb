class AddAppointmentCity < ActiveRecord::Migration
  def change
    add_column :appointments, :city, :string
  end
end
