class AddFeedbackSentToAppointments < ActiveRecord::Migration
  def change
    change_table :appointments do |t|
      t.boolean :feedback_sent, :default => false
    end
  end
end
