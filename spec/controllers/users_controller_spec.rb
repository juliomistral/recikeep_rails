require 'spec_helper'

describe UsersController do
  def setup_valid_new_user
    @user = double("new user")
    @user.stub(:id).and_return('user_id')
    User.any_instance.stub(:save).and_return(@user)
  end

  def setup_invalid_new_user
    User.any_instance.stub(:save).and_return(nil)
  end

  def setup_existing_user
    @user = double("existing user")
    @user.stub(:id).and_return('id')
    @controller.stubs(:current_user).returns(@user)
  end

  after(:each) do
    @user = nil
    User.rspec_reset
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    setup_invalid_new_user
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    setup_valid_new_user
    post :create
    response.should redirect_to(root_url)
    session['user_id'].should == assigns['user'].id
  end

  it "edit action should redirect when not logged in" do
    get :edit, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "edit action should render edit template" do
    setup_valid_new_user
    @controller.stubs(:current_user).returns(@user)
    get :edit, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when not logged in" do
    put :update, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "update action should render edit template when user is invalid" do
    setup_existing_user
    @user.stub(:update_attributes).and_return(nil)

    put :update, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when user is valid" do
    setup_existing_user
    @user.stub(:update_attributes).and_return(@user)

    put :update, :id => "ignored"
    response.should redirect_to(root_url)
  end
end
