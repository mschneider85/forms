class FormsController < ApplicationController
  before_action :load_form, only: [:edit, :update]

  def index
    @forms = Form.order(created_at: :desc).page(params[:page]).per(params[:per_page] || 10)
    authorize @forms
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
    head @form.update(form_attributes) ? :ok : :error
  end

  private

  def form_attributes
    params.require(:form).permit(:name, :slug).tap do |whitelisted|
      whitelisted[:structure] = JSON.parse(params[:form][:structure].presence || '{}') if params[:form][:structure]
    end
  end

  def load_form
    @form = Form.find_by(slug: params[:slug])
    unless @form
      flash[:error] = t('messages.not_found')
      redirect_to forms_path
    end
  end
end
