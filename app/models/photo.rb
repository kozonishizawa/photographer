# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :integer          not null
#

class Photo < ApplicationRecord
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
  has_many_attached :images, dependent: :detouch
  
  #----------------------------------------
  #  ** Delegates **
  #----------------------------------------

  #----------------------------------------
  #  ** Scopes **
  #----------------------------------------

  #----------------------------------------
  #  ** Methods **
  #----------------------------------------
  def thumbnail
    self.image.variant(combine_options: {resize: '640x640^', crop:'640x640+0+0',gravity: :center}).processed
  end
end
