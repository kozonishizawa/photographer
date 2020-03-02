# == Schema Information
#
# Table name: photos
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  album_id        :integer          not null
#  download_status :integer          default("0")
#  user_id         :integer          not null
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
  enum download_status: { unselected: 0, selected: 1, complete: 2, re_selected: 3 }
  
  #----------------------------------------
  #  ** Validations **
  #----------------------------------------

  
  #----------------------------------------
  #  ** Associations **
  #----------------------------------------
  belongs_to :user
  belongs_to :album
  has_one_attached :image, dependent: :detouch
  
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
    self.image
    # self.image.variant(resize: "#{length}x#{length}^").processed
  end
  # トリミング（縦横長さ指定）
  def rectangle_image(height,width)
    self.image
    # self.image.variant(resize: "#{height}x#{width}^").processed
  end
  
end
