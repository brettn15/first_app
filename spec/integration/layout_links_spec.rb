require 'spec_helper'

describe "Layout links" do
  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should render_template('users/new')
  end
end