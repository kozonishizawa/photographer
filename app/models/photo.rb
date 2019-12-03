# == Schema Information
#
# Table name: photos
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  album_id        :integer          not null
#  selection_id    :integer
#  download_status :integer          default("0")
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
  # validate :exceed_downloadable_limit
  #----------------------------------------
  #  ** Associations **
  #----------------------------------------
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
  # def exceed_downloadable_limit
  #   if Photo.where(download_status: 'selected').count > User.find_by(id: session[:user_id]).downloadable_limit
  #     errors.add(:download_status, "#{current_user.exceed_downloadable_limit}を超えています")
  #   end
  # end
  # トリミング（正方形）
  def square_image(length)
    self.image.variant(combine_options: {resize: "#{length}x#{length}^", crop:"#{length}x#{length}+0+0",gravity: :center}).processed
  end

  def rectangle_image(height,width)
    self.image.variant(combine_options: {resize: "#{height}x#{width}^", crop:"#{height}x#{width}+0+0",gravity: :center}).processed
  end
  
end
