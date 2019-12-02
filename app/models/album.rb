# == Schema Information
#
# Table name: albums
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  description     :text(65535)
#  status          :integer          default("0")
#  category        :integer          default("0")
#  photographed_at :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#

class Album < ApplicationRecord
  has_many_attached :images
  #----------------------------------------
  #  ** Includes **
  #----------------------------------------
  
  #----------------------------------------
  #  ** Constants **
  #----------------------------------------
  
  #----------------------------------------
  #  ** Enums **
  #----------------------------------------
  enum status: { closed: 0, personal: 1, open: 2 }
  #----------------------------------------
  #  ** Validations **
  #----------------------------------------
  validates :title, presence: true
  validates :title, presence: true
  #----------------------------------------
  #  ** Associations **
  #----------------------------------------
  belongs_to :user
  has_many :photos, dependent: :destroy
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
