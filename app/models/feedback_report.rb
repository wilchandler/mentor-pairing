class FeedbackReport
  def initialize(limit = nil)
    @limit = limit
  end

  def feedback
    query = AppointmentFeedback.order("created_at DESC")

    if @limit
      query = query.limit(@limit)
    end

    query.map { |f| FeedbackPresenter.new(f) }
  end

  def run
    feedback.each do |feedback|
      puts "#{feedback}\n\n"
    end
  end

  class FeedbackPresenter
    def initialize(feedback)
      @feedback = feedback
    end

    def giver_name
      @feedback.feedback_giver.name
    end

    def receiver_name
      @feedback.feedback_receiver.name
    end

    def text
      @feedback.text
    end

    def appointment_time
      @feedback.appointment.local_start_time
    end

    def to_s
      "#{giver_name}->#{receiver_name}: #{text} (#{appointment_time})"
    end
  end
end