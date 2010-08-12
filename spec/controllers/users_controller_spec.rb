require 'spec_helper'


    describe "when not signed in" do

      it "should protect 'following'" do
        get :following
        response.should redirect_to(signin_path)
      end

      it "should protect 'followers'" do
        get :followers
        response.should redirect_to(signin_path)
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @other_user = Factory(:user, :email => Factory.next(:email))
        @user.follow!(@other_user)
      end

      it "should show user following" do
        get :following, :id => @user
        response.should have_tag("a[href=?]", user_path(@other_user),
                                              @other_user.name)
      end

      it "should show user followers" do
        get :followers, :id => @other_user
        response.should have_tag("a[href=?]", user_path(@user), @user.name)
      end
    end
  end
end