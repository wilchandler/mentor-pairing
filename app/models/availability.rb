class Availability < ActiveRecord::Base
  include LocaltimeAdjustment

  CITIES = ["Chicago", "San Francisco", "New York", "Remote"]
  TIMEZONES = {
    "Chicago" => "Central Time (US & Canada)",
    "San Francisco" => "Pacific Time (US & Canada)",
    "New York" => "Eastern Time (US & Canada)"
  }
  PHYSICAL_LOCATIONS = CITIES - ['Remote']
  
  PHYSICAL_ROUTE_CONSTRAINT = lambda do |req| 
    Availability::PHYSICAL_LOCATIONS.include?(LocationHelper.slug_to_city(req[:city]))
  end

  attr_accessor :duration

  belongs_to :mentor, :class_name => "User"
  has_many :appointment_requests

  validates :start_time, :presence => true
  validates :city, inclusion: {in: CITIES }

  before_save :adjust_for_timezone
  before_save :set_end_time

  scope :visible, Proc.new {
    includes(:mentor).
    where("users.activated" => true).
    where("start_time > ?", Time.now)
  }

  scope :abandoned, -> {
    includes(:mentor).
    where("users.activated" => true).
    where("start_time < ?", Time.now)
  }
  
  def self.today(tz)
    now = Time.now
    where('start_time between ? and ?', 
      now.utc.to_s, 
      utc_eod_for_tz(now,tz).to_s)
  end


  def self.in_city(city)
    where(city: city)
  end

  def self.today_in_city(city)
    visible
      .today(TIMEZONES[city])
      .in_city(city)
  end

  private

  def self.utc_eod_for_tz(t, tz)
    t.in_time_zone(tz).end_of_day.utc
  end

  def adjust_for_timezone
    self.start_time = ActiveSupport::TimeZone.find_tzinfo(timezone).local_to_utc(start_time)
  end

  def set_end_time
    self.end_time = self.start_time + self.duration.to_i*60
  end

end
