# == Schema Information
#
# Table name: downloads
#
#  id                 :integer          not null, primary key
#  paid               :boolean          default("0"), not null
#  downloadable_limit :integer
#  download_status    :integer          default("0"), not null
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
  enum download_status: { incomplete: 0, complete: 1 }
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
  # ダウンロード上限の検証
  def verify_download_limit
    errors.add(:download_items, 'ダウンロード上限を超えています。' )if this.downloadable_status < this.download_items.count
  end
  # 支払い状況の検証
  def verify_payment_status
  end
end
