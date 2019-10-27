# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  room_id    :integer          not null
#  content    :text(65535)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ApplicationRecord

  belongs_to :room

  validates :content, presence: true
  # createの後にコミットする { MessageBroadcastJobのperformを遅延実行　引数はself }
  after_create_commit { MessageBroadcastJob.perform_later self }

end
