class Front::ContactsController < ApplicationController
  before_action :valid_contact, only: [:new, :create]
  def new
    @contact = Contact.find_or_initialize_by(id: session[:contact_id])
  end

  def create
    @contact = Contact.new contact_params
    if @contact.save
      session[:contact_id] = @contact.id
      redirect_to params[:new] ? new_front_user_url(session[:contact_id]) : front_contact_login_url(session[:contact_id])
    else
      render :new
    end
  end

  def edit
    @contact = Contact.find_by(id: session[:contact_id])
  end

  def update
    @contact = Contact.find(session[:contact_id])
    @contact.update! contact_params
    redirect_to params[:new] ? new_front_user_url : front_contact_login_url(session[:contact_id])
  end

  def login
  end

  private
    def contact_params
      params.require(:contact).permit(:subject, :date, :location, :request)
    end

    # session[:contact_id]がすでに存在する場合は編集画面へリダイレクトする
    def valid_contact
      if session[:contact_id] && @contact.present?
        redirect_to edit_front_contact_url(session[:contact_id])
      end
    end
end
