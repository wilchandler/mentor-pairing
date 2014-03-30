require "spec_helper"

describe Availability do
  it { should belong_to(:mentor) }

  describe "when first created" do
    before(:each) do
      @start_time = DateTime.new(2013, 1, 1)
      @availability = FactoryGirl.create(:availability,
        start_time: @start_time,
        city: 'Chicago')
    end

    it "should have a start_time" do
      expect(@availability.start_time).to eq(@start_time)
    end

    it "should have an end_time which is the duration times 60" do
      expect(@availability.end_time).to eq(@availability.start_time + 1800)
    end

    context "length" do
      it "should be 30 minutes long" do
        expect(@availability.end_time - @availability.start_time).to eq(1800)
      end
    end

    context "when validating city" do
      it { should ensure_inclusion_of(:city).in_array(Availability::CITIES) }
    end

    describe '::today' do
      it 'should check start_time bounds for today' do
        now = Time.new(2013,12,2,0,0,0, "-05:00")
          .in_time_zone("Eastern Time (US & Canada)")
        
        Time.stub(:now) { now }

        utc_eod = Availability.utc_eod_for_tz(now, "Central Time (US & Canada)")

        expect(Availability)
          .to(receive(:where)
            .with('start_time between ? and ?', 
              now.utc.to_s,
              utc_eod.to_s))

        Availability.today("Central Time (US & Canada)")
      end
    end

    describe '::utc_eod_for_tz' do
      it "should produce a locale's EOD as UTC" do
        time_in_est = Time.new(2013,12,2,0,0,0, "-05:00")
          .in_time_zone("Eastern Time (US & Canada)")

        cst_eod = Time.new(2013,12,1,23,59,59, "-06:00")
          .in_time_zone("Central Time (US & Canada)")

        Availability
          .utc_eod_for_tz(time_in_est, "Central Time (US & Canada)")
          .to_s
          .should eq(cst_eod.utc.to_s)
      end
    end

    describe '::TIMEZONES' do
      it 'should include all physical cities' do
        Availability::TIMEZONES.keys.should =~ Availability::PHYSICAL_LOCATIONS
      end
    end

    describe '::PHYSICAL_ROUTE_CONSTRAINT' do
      it 'should reject invalid cities' do
        Availability::PHYSICAL_ROUTE_CONSTRAINT.call(city:'atlantis')
          .should be_false
      end

      it 'should reject remote' do
        Availability::PHYSICAL_ROUTE_CONSTRAINT.call(city:'remote')
          .should be_false
      end

      it 'should accept valid city' do
        Availability::PHYSICAL_ROUTE_CONSTRAINT.call(city:'san-francisco')
          .should be_true
      end
    end
  end
end
