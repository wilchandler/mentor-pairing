require 'spec_helper'

describe LocationHelper do
	context '#city_to_slug' do
		it "should convert full city names to slugs" do
			helper.send(:city_to_slug, "Foo Bar").should eq("foo-bar")
		end
	end

	context '#slug_to_city' do
		it "should convert slugs to full city names" do
			helper.send(:slug_to_city, "foo-bar").should eq("Foo Bar")
		end

		it "should be idempotent" do
			helper.send(:slug_to_city, "Foo Bar").should eq("Foo Bar")
		end
	end
end
