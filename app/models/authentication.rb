require 'active_support/core_ext/hash'
class Authentication
  attr_reader :user

  def initialize(auth_hash)
    auth_hash = HashWithIndifferentAccess.new(auth_hash)
    raise "auth_hash requires :provider and :id key" unless auth_hash.has_key?(:provider) && auth_hash.has_key?(:id)
    @user = user_factory.find_or_create_by_provider_and_provider_id(provider: auth_hash[:provider], provider_id: auth_hash[:id])
    @user.update_attributes({
      email:   auth_hash.fetch(:email),
      twitter_handle: auth_hash.fetch(:twitter, ""),
      name:    auth_hash.fetch(:name, "")
    })
  end

  def self.user_factory=(factory)
    @@user_factory = factory
  end

  def self.user_factory
    if class_variable_defined?("@@user_factory") && @@user_factory
      return @@user_factory
    else
      begin
        return User
      rescue
      end
    end
    raise  "Provide Authentication with a user factory that responds to find_or_create"
  end

  private
  def user_factory
    self.class.user_factory
  end
end
