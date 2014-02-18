namespace :feedback do
  task :send_all_requests => :environment do
    FeedbackRequestSender.new.send_all_requests
  end
end