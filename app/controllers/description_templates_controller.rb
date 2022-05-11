class DescriptionTemplatesController < ApplicationController
  def index
    @description_templates = current_user.description_templates.all
  end

  def new
    @description_template = current_user.description_templates.new
  end

  def create
    @description_template =
      current_user.description_templates.build(description_template_params)

    if @description_template.save
      redirect_to(description_templates_path)
    else
      flash.now[:error] = @description_template.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @description_template =
      current_user.description_templates.find(params.fetch(:id))

    if @description_template.update(description_template_params)
      redirect_to(description_templates_path)
    else
      flash.now[:error] = @description_template.errors.full_messages.to_sentence
      render :edit
    end
  end

  def edit
    @description_template =
      current_user.description_templates.find(params.fetch(:id))
  end

  private

  def description_template_params
    params.require(:description_template).permit(:name, :template)
  end
end
