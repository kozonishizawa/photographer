# == Schema Information
#
# Table name: contact_statuses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  order       :integer
#  color       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ContactStatus < ApplicationRecord
  def set_order
    self.order = ContactStatus.count
    self.save!
  end
end
