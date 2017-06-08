class CampaignsController < ApplicationController
  before_action :load_campaign, only: [:edit, :update, :destroy]

  def index
    @campaigns = policy_scope(Campaign).page(params[:page]).per(params[:per_page] || 10)
    authorize @campaigns
  end

  def new
    @campaign = current_user.campaigns.build
  end

  def create
    @campaign = current_user.campaigns.build(campaign_attributes)
    if @campaign.save
      redirect_to campaigns_path, notice: 'Saved'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @campaign.update(campaign_attributes)
      redirect_to campaigns_path, notice: 'Updated'
    else
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_path, notice: 'Deleted'
  end

  private

  def load_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_attributes
    params.require(:campaign).permit(:name, :path, :locale, :starting_at, :ending_at)
  end
end
