require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "Users#new" do
    it "renders a new page" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "Users#create" do
    context "with valid params" do
      it "redirects to goals index" do
        post :create, params: { user: { username: "Test", password: "123456" }}
        expect(response).to redirect_to(goals_url)
      end

      it "saves user to the database" do
        post :create, params: { user: { username: "hello", password: "password" } }
        expect(User.find_by(username: "hello").nil?).to be false
      end
    end

    context "with invalid params" do
      it "renders the Sign Up page" do
        post :create, params: { user: { username: "Boris", password: "2" } }
        expect(response).to render_template(:new)
      end
      it "displays errors" do
        post :create, params: { user: { username: "Boris", password: "2" } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end
  end
end
