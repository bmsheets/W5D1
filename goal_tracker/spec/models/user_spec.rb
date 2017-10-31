require 'rails_helper'

RSpec.describe User, type: :model do

  # subject(:user) { FactoryBot.create(:user)}
  subject(:user) { User.create(username: "Boris", password: "123456") }

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }

    # it "validates username presence"
    # it "validates password length"
    # it "validates password_digest presence"
    # it "validates session_token presence"
  end

  describe "associations" do
    it { should have_many (:goals) }
    it { should have_many (:comments) }
    it { should have_many (:cheers) }
    # it "has many goals"
    # it "has many comments"
    # it "has many cheers"
  end

  describe "class/instance methods" do
    it "can set a password" do
      user.password = "123847"
      expect(user.password).to eq("123847")
    end

    it "checks valid password" do
      user.password = "165434"
      expect(user.is_password?("165434")).to be true
      expect(user.is_password?("lime")).to be false
    end

    it "ensures session token" do
      user = User.new
      expect(user.session_token.nil?).to be false
    end

    it "resets session token" do
      user = User.new
      sesh = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(sesh)
    end

    it "can be found by username/password" do
      test_user = User.new(username: "Boris")
      test_user.password = "123456"
      test_user.save
      expect(User.find_by_credentials("Boris", "123456").nil?).to be false
    end
  end

end
