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
#  open_period     :integer          default("0"), not null
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
  enum category: { unknown: 0,seven_five_three: 1, birthday: 2, shrine_visit: 3, half_birth: 4, maternity: 5, entrance_or_graduation_ceremony: 6, before_adult_ceremony: 7, family_photo: 8, wedding_ceremony_and_reception: 9, wedding_ceremony: 10, wedding_reception: 11, wedding_party: 12, other_events: 13, profile: 14}

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
  def self.ransackable_attributes(auth_object = nil)
    %w[title photographed_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end
end
