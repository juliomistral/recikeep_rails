require 'spec_helper'

describe SessionsController do
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when authentication is invalid" do
    User.stubs(:authenticate_login).returns(nil)
    post :create
    response.should render_template(:new)
    session['user_id'].should be_nil
  end

  it "create action should redirect when authentication is valid" do
    user = stub(:id => 'id')
    User.stubs(:authenticate_login).returns(user)

    post :create
    response.should redirect_to(root_url)
    session['user_id'].should == 'id'
  end
end
