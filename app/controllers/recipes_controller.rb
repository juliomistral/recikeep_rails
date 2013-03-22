class RecipesController < ApplicationController
  before_filter :login_required

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.user = current_user

    if @recipe.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def index
    @user_recipes = Recipe.find_all_by_user_id(current_user.id)
  end

end