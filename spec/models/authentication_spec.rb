require 'unit_spec_helper'
require 'authentication'

describe Authentication do
  describe "#initialize" do
    context "when there is not a user factory" do
      it "Raises an error stating you need a user factory" do
        Authentication.user_factory=nil
        expect {
          Authentication.new(provider: :devbootcamp, id: 1, email: "foo@example.com")
        }.to raise_error "Provide Authentication with a user factory that responds to find_or_create"
      end
    end

    let(:fake_user) { double(update_attributes: nil) }
    let(:fake_user_factory) { double() }
    let(:authentication) {
      fake_user_factory.stub(:find_or_create_by_provider_and_provider_id).with(provider: :devbootcamp, provider_id: 1).and_return(fake_user)
      Authentication.user_factory = fake_user_factory
      Authentication.new(provider: :devbootcamp, id: 1,
                         :email => "foo@example.com",
                         "twitter" => "@foo",
                         :name => "Foo Bar")
    }

    it "exposes the user that is found by the provider/provider_id" do
      expect(authentication.user).to eq(fake_user)
    end

    it "Updates the user with the data from the auth_hash" do
      authentication
      expect(fake_user).to have_received(:update_attributes).with({
        email:  "foo@example.com",
        twitter_handle: "@foo",
        name:    "Foo Bar"
      })

    end
  end
end
