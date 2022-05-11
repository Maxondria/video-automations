class PresentersController < ApplicationController
  before_action :set_presenter, except: %i[index new create destroy]

  def index
    @presenters = current_user.presenters.all
  end

  def new
    @presenter = current_user.presenters.new
  end

  def show; end

  def edit; end

  def create
    @presenter = current_user.presenters.build(presenter_params)

    if @presenter.save
      redirect_to presenters_path
    else
      flash.now[:error] = @presenter.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @presenter.update(presenter_params)
      redirect_to presenters_path
    else
      flash.now[:error] = @presenter.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def presenter_params
    params.require(:presenter).permit(:name, :twitter_handle, :linked_in, :role)
  end

  def set_presenter
    @presenter = current_user.presenters.find(params.fetch(:id))
  end
end
