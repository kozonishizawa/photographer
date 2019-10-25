class Front::ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to new_front_contact_path, flash: {success: "送信しました"}
    else
      render :new
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :tel, :subject, :date, :location, :request, :approval)
    end
end
