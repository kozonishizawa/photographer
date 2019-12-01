# == Schema Information
#
# Table name: selections
#
#  id                 :integer          not null, primary key
#  paid               :boolean
#  downloadable_limit :integer
#  download_status    :integer
#  album_id           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Selection < ApplicationRecord
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
