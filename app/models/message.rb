# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text(65535)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :integer
#

class Message < ApplicationRecord
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
  validates :content, presence: true
  
  #----------------------------------------
  #  ** Associations **
  #----------------------------------------
  belongs_to :user
  belongs_to :room
  #----------------------------------------
  #  ** Delegates **
  #----------------------------------------
  
  #----------------------------------------
  #  ** Scopes **
  #----------------------------------------
  
  #----------------------------------------
  #  ** Methods **
  #----------------------------------------
  # createの後にコミットする { MessageBroadcastJobのperformを遅延実行　引数はself }
  after_create_commit { MessageBroadcastJob.perform_later self }
  
end
