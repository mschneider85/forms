class Campaign < ApplicationRecord
  LOCALES = %w(de en).freeze

  has_many :campaigns_users
  has_many :users, through: :campaigns_users

  attr_accessor :ending_at_date

  jsonb_accessor :settings,
    locale: [:string, default: 'de'],
    starting_at: :datetime,
    ending_at: :datetime,
    ts: :time

  enum status: {
    setup: 0,
    published: 1
  }

  validates :name, presence: true
  validates :path, uniqueness: true
  validates :locale, presence: true, inclusion: { in: LOCALES }
  validate do
    if starting_at && ending_at && ending_at <= starting_at
      errors.add :ending_at, :must_be_after_start_date
    end
  end

  def self.locales
    LOCALES.map { |locale| [I18n.t("languages.#{locale}"), locale] }
  end
end
