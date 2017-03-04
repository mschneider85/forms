class FormsController < ApplicationController
  before_action :load_form, only: [:edit, :update]

  def index
    @forms = Form.all
  end

  def new
    @form = Form.new
  end

  def create
    @form = Form.new(form_attributes)
    if @form.save
      redirect_to edit_form_path(@form)
    end
  end

  def edit
  end

  def update
    @form.structure = JSON.parse(form_attributes[:structure])
    head @form.save ? :ok : :error
  end

  private

  def form_attributes
    params.require(:form).permit(:name, :slug, :structure)
  end

  def load_form
    @form = Form.find_by(slug: params[:slug])
  end
end
