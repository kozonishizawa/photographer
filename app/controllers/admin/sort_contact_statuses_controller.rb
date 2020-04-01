class Admin::SortContactStatusesController < ApplicationController
  def update
    contact_status = ContactStatus.find(params[:id])
    case params[:move]
    when 'up'
      contact_status.move_higher
      target = contact_status.lower_item
    when 'down'
      contact_status.move_lower
      target = contact_status.higher_item
    else
      return head :ok
    end
  end
end
