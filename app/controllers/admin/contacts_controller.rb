class Admin::ContactsController < ApplicationController
  before_action :required_admin
  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find_by(id: params[:id])
  end
end
