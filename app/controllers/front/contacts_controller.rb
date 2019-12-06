class Front::ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new contact_params
    if @contact.save
      redirect_to new_front_root_url
    else
      render :new
    end
  end

  private
    def contact_params
      params.require(:contact).permit :subject, :date, :location, :request, :user_id
    end

end
