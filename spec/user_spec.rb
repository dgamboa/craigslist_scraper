require_relative '../lib/user'

describe User do

  before(:each) do
    @user = User.new('user@email.com', "User")
  end

  context ".initialize" do

    it "has an email address" do
      @user.email.should match(/@/)
    end



  end

end