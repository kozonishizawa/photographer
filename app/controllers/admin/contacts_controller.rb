class Admin::ContactsController < Admin::ApplicationController
  before_action :required_admin
  
  def index
    @contact_statuses = ContactStatus.all
    @q = Contact.ransack(params[:q])
    @contacts = @q.result.distinct.reverse_order.page(params[:page])
  end

  def show
    @contact = Contact.find_by(id: params[:id])
  end
end
