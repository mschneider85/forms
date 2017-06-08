class FormElementsController < ApplicationController
  def edit
    @field_setting_form = FieldSettingForm.new(params.require(:field_setting_form).permit!.merge(id: params[:id]))
  end

  def update
    @field_setting_form = FieldSettingForm.new(params[:field_setting_form].permit!.merge(id: params[:id]))
    form = Form.find_by('structure::text ILIKE ?', "%#{@field_setting_form.id}%")
    rows = form.rows.each do |row|
      row[:columns].each do |column|
        next unless column[:id] == @field_setting_form.id
        @col = column
        @field_setting_form.attributes.each do |key, value|
          column[key] = value
        end
      end
    end
    form.update(structure: { rows: rows })
  end

  def permit!
    each_pair do |key, value|
      convert_hashes_to_parameters(key, value)
      self[key].permit! if self[key].respond_to? :permit!
    end

    @permitted = true
    self
  end
end
