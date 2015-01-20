module SelectDateTimeHelper
  def select_datetime(datetime, field, time_options={})
    fill_in :availability_start_time_1s, with: datetime.strftime("%Y-%m-%d")
    {
      "4i" => (lambda { |dt| dt.strftime("%l").strip }),
      "5i" => (lambda { |dt| ['00','15','30','45'].min_by {|m| (m.to_i - dt.min).abs } }),
      "6i" => (lambda { |dt| dt.strftime("%p") })
    }.each do |sub_field, translation|
      select translation.call(datetime), from: "#{field}_#{sub_field}_"
    end
  end
end

module RSpec::Rails::FeatureExampleGroup
  include SelectDateTimeHelper
end
