class JournalEntriesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @journal_entry = JournalEntry.new
    @journal_entry.media_files.build
    @campaigns = current_user.campaigns
  end

  def create
    @journal_entry = JournalEntry.new(journal_entry_params)
    @journal_entry.user_id = current_user.id
    if @journal_entry.save
      campaign = @journal_entry.campaign
      flash[:notice] = "Journal entry created successfully for \"#{campaign.title}\"."
      redirect_to campaign_path(@journal_entry.campaign)
    else
      @campaigns = current_user.campaigns
      flash.now[:alert] = @journal_entry.errors.full_messages.join(". ") + "."
      render "new"
    end
  end

  def edit
    @journal_entry = JournalEntry.find(params[:id])
    @campaigns = current_user.campaigns
  end

  def update
    @journal_entry = JournalEntry.find(params[:id])
    @journal_entry.assign_attributes(journal_entry_params)
    if @journal_entry.save
      campaign = @journal_entry.campaign
      flash[:notice] = "Journal entry updated successfully for \"#{campaign.title}\"."
      redirect_to campaign_path(@journal_entry.campaign)
    else
      @campaigns = current_user.campaigns
      flash.now[:alert] = @journal_entry.errors.full_messages.join(". ") + "."
      render "edit"
    end
  end

  def destroy
    journal_entry = JournalEntry.find(params[:id])
    path_to_go_to_after = campaign_path(journal_entry.campaign)
    journal_entry.destroy
    flash[:notice] = "Journal entry successfully deleted."
    redirect_to path_to_go_to_after
  end

  private 

  def journal_entry_params
    params.require(:journal_entry).permit(
      :id,
      :dates,
      :hours,
      :description,
      :user_id,
      :campaign_id,
      :_destroy,
      media_files_attributes: [
        :id,
        :image,
        :caption,
        :_destroy
      ]
    )
  end
end