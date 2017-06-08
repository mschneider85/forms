class CampaignsUser < ApplicationRecord
  belongs_to :campaign, inverse_of: :campaigns_users
  belongs_to :user, inverse_of: :campaigns_users
end
