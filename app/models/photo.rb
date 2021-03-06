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
  enum download_status: { unselected: 0, selected: 1, complete: 2 }
  
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
  # 未選択の写真
  scope :unselected, -> { where(download_status: 'unselected') }
  # 選択された写真
  scope :selected, -> { where(download_status: 'selected') }
  #----------------------------------------
  #  ** Methods **
  #----------------------------------------
  # トリミング（正方形）
  def square_image(length)
    self.image.variant(combine_options: {resize: "#{length}x#{length}^", crop:"#{length}x#{length}+0+0",gravity: :center}).processed
  end
  # トリミング（縦横長さ指定）
  def rectangle_image(height,width)
    self.image.variant(combine_options: {resize: "#{height}x#{width}^", crop:"#{height}x#{width}+0+0",gravity: :center}).processed
  end
  
end
