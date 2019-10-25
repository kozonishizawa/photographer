class Admin::HomeController < ApplicationController
  before_action :required_admin
  
  def index
  end
end
