class Form < ApplicationRecord
  serialize :structure, JSONWithIndifferentAccess

  validates :name, presence: true
  validates :slug, uniqueness: true

  def to_param
    slug
  end

  before_save do
    self.slug ||= generate_slug if new_record?
  end

  private

  def generate_slug(string = name)
    (0..(1 / 0.0)).each do |i|
      length = 29 - (i > 0 ? (i.to_s.length + 1) : 0)
      @slug = string[0..length].downcase.gsub(/[^a-z0-9 ]/, ' ').strip.gsub(/[ ]+/, '-') + (i > 0 ? "-#{i}" : '')
      break unless self.class.exists?(slug: @slug)
    end
    @slug
  end
end
