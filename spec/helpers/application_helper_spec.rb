require 'spec_helper'

describe ApplicationHelper do
  context "month_link" do
    before :each do
      @date = DateTime.new(2013, 1, 1)
    end
    it "links to the previous month" do
      link = month_link("<", "/path-thing", @date.beginning_of_month - 1)
      expect(link).to eq("<a href=\"/path-thing?month=2012-12-01\">&lt;</a>")
    end

    it "links to the next month" do
      link = month_link("<", "/path-thing", @date.end_of_month + 1)
      expect(link).to eq("<a href=\"/path-thing?month=2013-02-01\">&lt;</a>")
    end
  end
end
