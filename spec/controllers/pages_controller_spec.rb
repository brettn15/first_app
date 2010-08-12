require 'spec_helper'

describe PagesController do
  integrate_views

  before(:each) do
    #
    # Define @base_title here.
    #
  end

  
describe "GET 'home'" do

    describe "when not signed in" do

      before(:each) do
        get :home
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_tag("title", "#{@base_title} | Home")
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.follow!(@user)
      end

      it "should have the right follower/following counts" do
        get :home
        response.should have_tag("a[href=?]", following_user_path(@user), 
                                              /0 following/)
        response.should have_tag("a[href=?]", followers_user_path(@user), 
                                              /1 follower/)
      end
    end
  end
end
