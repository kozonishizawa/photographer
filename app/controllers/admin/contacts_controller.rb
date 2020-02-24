class Admin::ContactsController < Admin::ApplicationController
  before_action :required_admin
  
  def index
    @q = Contact.ransack(params[:q])
    @contacts = @q.result(distinct: true).reverse_order.page(params[:page])
  end

  def show
    @contact = Contact.find_by(id: params[:id])
  end
end
