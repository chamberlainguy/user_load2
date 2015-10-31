# == Schema Information
#
# Table name: users
#
#  id                                                                    :integer          not null, primary key
#  email_address                                                         :string           default(""), not null
#  first_name                                                            :string           default(""), not null
#  last_name                                                             :string           default(""), not null
#  created_at                                                            :datetime
#  updated_at                                                            :datetime
#  parent_id                                                             :integer
#  #<ActiveRecord::ConnectionAdapters::TableDefinition:0x007fd162c97288> :integer
#

class User < ActiveRecord::Base
 			
 	belongs_to :reports_to_user, class_name: 'User', foreign_key: :parent_id

 	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  		validates :email_address, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
 
 	
end


