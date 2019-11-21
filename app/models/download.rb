# == Schema Information
#
# Table name: downloads
#
#  id                 :integer          not null, primary key
#  payment_status     :integer
#  downloadable_limit :integer
#  download_status    :integer
#  album_id           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Download < ApplicationRecord
  #----------------------------------------
  #  ** Includes **
  #----------------------------------------
  
  #----------------------------------------
  #  ** Constants **
  #----------------------------------------
  
  #----------------------------------------
  #  ** Enums **
  #----------------------------------------
  
  #----------------------------------------
  #  ** Validations **
  #----------------------------------------
  
  #----------------------------------------
  #  ** Associations **
  #----------------------------------------
  belongs_to :album
  has_many :download_items
  #----------------------------------------
  #  ** Delegates **
  #----------------------------------------
  
  #----------------------------------------
  #  ** Scopes **
  #----------------------------------------
  
  #----------------------------------------
  #  ** Methods **
  #----------------------------------------
end
