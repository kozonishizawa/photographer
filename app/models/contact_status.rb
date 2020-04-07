# == Schema Information
#
# Table name: contact_statuses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  position    :integer
#  color       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ContactStatus < ApplicationRecord

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
  before_destroy :validate_number_of_statuses
  #----------------------------------------
  #  ** Associations **
  #----------------------------------------
  has_many :contacts, dependent: :restrict_with_exception
  #----------------------------------------
  #  ** Delegates **
  #----------------------------------------

  #----------------------------------------
  #  ** Scopes **
  #----------------------------------------

  #----------------------------------------
  #  ** Methods **
  #----------------------------------------
  acts_as_list

  private
    # ステータス数の下限を検証
    def validate_number_of_statuses
      min_number_of_contact_statuses = 2
      raise RuntimeError if ContactStatus.count <= min_number_of_contact_statuses
    end

end
