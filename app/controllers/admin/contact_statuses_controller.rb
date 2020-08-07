class Admin::ContactStatusesController < Admin::ApplicationController
  before_action :required_admin
  
  def index
    @contact_statuses = ContactStatus.order(:position)
  end

  def new
    @contact_status = ContactStatus.new
  end

  def create
    @contact_status = ContactStatus.new contact_status_params
    if @contact_status.save
      redirect_to admin_contact_statuses_url, flash: { success: 'ステータスを登録しました' }
    else
      render :new
    end
  end

  def edit
    @contact_status = ContactStatus.find(params[:id])
  end

  def update
    @contact_status = ContactStatus.find(params[:id])
    @contact_status.update!(contact_status_params)
    redirect_to admin_contact_statuses_url, flash: { success: 'ステータスを編集しました' }
  end

  def destroy
    @contact_status = ContactStatus.find(params[:id])
    begin
      @contact_status.destroy
    rescue ActiveRecord::DeleteRestrictionError
      redirect_to admin_contact_statuses_url, flash: { danger: 'このステータスは使用中です' }
    rescue RuntimeError
      redirect_to admin_contact_statuses_url, flash: { danger: 'ステータスは２つ以上必要です' }
    else
      redirect_to admin_contact_statuses_url, flash: { success: 'ステータスを削除しました' }
    end
  end

  private
    def contact_status_params
      params.require(:contact_status).permit :name, :description, :position, :color
    end
    
end
