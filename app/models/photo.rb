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
  has_one_attached :image, dependent: :detouch
  # has_many_attached :images, dependent: :detouch
  
  #----------------------------------------
  #  ** Delegates **
  #----------------------------------------

  #----------------------------------------
  #  ** Scopes **
  #----------------------------------------

  #----------------------------------------
  #  ** Methods **
  #----------------------------------------
  # トリミング（正方形）
  def square_image(length)
    self.image.variant(combine_options: {resize: "#{length}x#{length}^", crop:"#{length}x#{length}+0+0",gravity: :center}).processed
  end

  def rectangle_image(height,width)
    self.image.variant(combine_options: {resize: "#{height}x#{width}^", crop:"#{height}x#{width}+0+0",gravity: :center}).processed
  end

end
