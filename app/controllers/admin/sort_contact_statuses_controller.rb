class Admin::SortContactStatusesController < Admin::ApplicationController
  before_action :required_admin

  def update
    contact_status = ContactStatus.find(params[:id])
    contact_status.insert_at(params[:new_position].to_i + 1)
    head :ok
  end
end
