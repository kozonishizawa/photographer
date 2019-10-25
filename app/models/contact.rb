# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  email      :string(255)      not null
#  tel        :string(255)      not null
#  subject    :integer          not null
#  date       :date             not null
#  location   :string(255)      not null
#  request    :text(65535)
#  approval   :integer          default("0"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ApplicationRecord
  #----------------------------------------
  #  ** Includes **
  #----------------------------------------

  #----------------------------------------
  #  ** Constants **
  #----------------------------------------

  #----------------------------------------
  #  ** Enums **
  #----------------------------------------

  enum subject: { seven_five_three: 0, birthday: 1, shrine_visit: 2, half_birth: 3, maternity: 4, entrance_or_graduation_ceremony: 5, before_adult_ceremony: 6, family_photo: 7, wedding_ceremony_and_reception: 8, wedding_ceremony: 9, wedding_reception: 10, wedding_party: 11, other_events: 12, profile: 13}

  #----------------------------------------
  #  ** Validations **
  #----------------------------------------
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :tel, presence: true
  validates :subject, presence: true
  validates :date, presence: true
  validates :location, presence: true


  #----------------------------------------
  #  ** Associations **
  #----------------------------------------

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
