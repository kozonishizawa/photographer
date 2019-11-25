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
  has_many :photos

  #----------------------------------------
  #  ** Delegates **
  #----------------------------------------
  
  #----------------------------------------
  #  ** Scopes **
  #----------------------------------------
  
  #----------------------------------------
  #  ** Methods **
  #----------------------------------------
  # 支払い状況の検証
  def verify_payment_status
  end
end
