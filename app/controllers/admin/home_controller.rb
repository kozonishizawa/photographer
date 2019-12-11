class Admin::HomeController < Admin::ApplicationController
  before_action :required_admin
  
  def index
  end
end
