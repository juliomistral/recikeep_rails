require 'spec_helper'

describe RecipesController do
  let(:recipe) { return mock_model(Recipe, :id => 1, :name => 'a name') }
  let(:user) { return mock_model(User, :user_id => 'user id')   }
  before(:each) { @controller.stubs(:current_user).returns(user) }

  #context 'Rendering empty recipe page' do
  #  before(:each) do
  #    @controller.stubs(:current_user).returns(user)
  #    Recipe.stub!(:new).with(no_args).and_return(@recipe)
  #  end
  #
  #  it 'should assign an empty recipe model' do
  #
  #  end
  #
  #  it 'should render the new recipe form' do
  #    response.should render_template(:new)
  #  end
  #end


  context '#create' do
    let(:params) do
      {
          'recipe' => {
              'name' => 'a name',
              'tag_block' => 'tag 1, tag 2',
              'ingredient_block' => 'ingredient 1\n ingredient 2 \n ingredient 3',
              'step_block' => 'step 1\n step 2\n step 3\n step 4'
          }
      }
    end

    before(:each) do
      Recipe.stub!(:new).with(any_args).and_return(recipe)
      recipe.stub(:save).with(no_args).and_return(true)
      recipe.stub(:user=).with(any_args).and_return(nil)
    end

    it 'should create a new recipe using form parameters' do
      Recipe.should_receive(:new).with(params['recipe'])
      post :create, params
    end

    it 'should associate the current user with the created recipe' do
      recipe.should_receive(:user=).with(user)
      post :create, params
    end

    it 'should redirect to the recipe list page if the recipe is saved' do
      post :create, params
      response.should redirect_to(recipes_path)
    end

    it 'should redirect back to the create page if the recipe is invalid' do
      recipe.stub(:save).with(no_args).and_return(false)
      post :create, params
      response.should render_template(:new)
    end
  end

  context '#index' do
    it 'should find recipes for the current session user' do
      Recipe.should_receive(:find_all_by_user_id).with(user.id).and_return([recipe])
      get :index
    end
  end
end