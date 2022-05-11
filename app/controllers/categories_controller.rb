class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update]

  def index
    @categories = current_user.categories.all
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to categories_path
    else
      flash.now[:alert] = @video.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path
    else
      flash.now[:alert] = @category.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def set_category
    @category = current_user.categories.find(params.fetch(:id))
  end

  def category_params
    params.require(:category).permit(:name, :title_color, :subtitle_color)
  end
end
