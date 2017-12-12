class RecipesController < ApplicationController

# GET displays all the recipes
  def index
    @recipes = Recipe.all
  end

# GET displaying just the selected recipe you want not all of them
  def show
    @recipe = Recipe.find(params[:id])
  end

# GET form for new recipe but DOES NOT save it to the db
  def new
    @recipe = Recipe.new
  end

# GETS form for editing recipe but DOES NOT save it to the db
  def edit
    @recipe = Recipe.find(params[:id])
  end

# POSTS the form to the model to save to the db
  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

# PATCHES information based off your edit form and saves it to the db
  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

# DELETE from db
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path
  end

  def search
      @recipes = Recipe.where("name LIKE ?", "%#{params[:search]}")

  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :instructions)
  end
end
