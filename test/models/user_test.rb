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
require 'test_helper'
require 'byebug'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "user fields should not be blank" do
    aUser = User.new(password_digest: BCrypt::Password.create('stuff'))
    assert aUser.invalid?

    aUser.name = "Bob"
    assert aUser.invalid?

    aUser.email = "hi@hi.com"
    assert aUser.valid?
  end

  test "user name should be unique" do
    dupUser = User.new(name: users(:one).name, password_digest: BCrypt::Password.create('more stuff'), email: "hi")
    assert dupUser.invalid?

    dupUser.name = "Chris"
    assert dupUser.valid?
  end
end
