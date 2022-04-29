class PresentersController < ApplicationController
  def index
    @presenters = Presenter.all
  end

  def new
    @presenter = Presenter.new
  end

  def show
    @presenter = Presenter.find(params.fetch(:id))
  end

  def create
    @presenter = Presenter.new(presenter_params)

    if @presenter.save
      redirect_to presenters_path
    else
      flash.now[:error] = @presenter.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @presenter = Presenter.find(params.fetch(:id))

    if @presenter.update(presenter_params)
      redirect_to presenters_path
    else
      flash.now[:error] = @presenter.errors.full_messages.to_sentence
      render :edit
    end
  end

  def edit
    @presenter = Presenter.find(params.fetch(:id))
  end

  private

  def presenter_params
    params.require(:presenter).permit(:name, :twitter_handle, :linked_in, :role)
  end
end
