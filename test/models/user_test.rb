# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
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

  test "user should have name" do
    aUser = User.new(password_digest: "stuff")
    assert aUser.invalid?

    aUser.name = "Bob"
    assert aUser.valid?
  end

  test "user name should be unique" do
    dupUser = User.new(name: users(:one).name, password_digest: "moreStuff")
    assert dupUser.invalid?

    dupUser.name = "Chris"
    assert dupUser.valid?
  end
end
