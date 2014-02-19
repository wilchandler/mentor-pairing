class CreateAppointmentFeedbacks < ActiveRecord::Migration
  def change
    create_table :appointment_feedbacks do |t|
      t.integer :appointment_id, :null => false
      t.integer :feedback_giver_id, :null => false
      t.integer :feedback_receiver_id, :null => false
      t.text :text, :null => false
      t.timestamps
    end
  end
end
