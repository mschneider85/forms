class Form < ApplicationRecord
  default_scope { order(created_at: :asc) }

  validates :name, presence: true
  validates :slug, uniqueness: true

  def to_param
    slug
  end

  before_save do
    slug || generate_slug if new_record?
  end

  def structure
    self[:structure].with_indifferent_access
  end

  def rows
    structure[:rows] || {}
  end

  def generate_slug(string = name)
    (0..(1 / 0.0)).each do |i|
      length = 29 - (i.positive? ? (i.to_s.length + 1) : 0)
      @slug = string[0..length].downcase.gsub(/[^a-z0-9 ]/, ' ').strip.gsub(/[ ]+/, '-') + (i.positive? ? "-#{i}" : '')
      break unless self.class.exists?(slug: @slug)
    end
    self.slug = @slug
  end
end
