# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  after_destroy :keep_last_admin

  class UserError < StandardError
    
  end

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: false
  has_secure_password

  def keep_last_admin
    raise UserError.new "Can't delete last user" if User.count.zero?
  end
  
end
