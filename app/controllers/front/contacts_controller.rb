class Front::ContactsController < Front::ApplicationController

  def index
    @contacts = current_user.contacts
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new contact_params
    if @contact.save
      redirect_to front_root_url, flash: { success: '依頼を送信しました'}
    else
      render :new
    end
  end

  private
    def contact_params
      params.require(:contact).permit :subject, :date, :location, :request, :user_id
    end

end
