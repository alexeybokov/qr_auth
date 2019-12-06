require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:valid_user) }

  describe 'GET #new' do
    before do
      allow(User).to receive(:new).and_return(user)
      get :new
    end

    it 'has a 200 status code' do
      expect(response).to be_ok
    end

    it 'assigns instance variable' do
      expect(assigns[:user]).to eq(user)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'save user with valid attributes' do
        expect(user.save!).to be true
      end

      it 'after success create user redirect to show qr_code' do
        post :create, params: { user: attributes_for(:valid_user) }
        expect(response).to redirect_to(show_qr_path(id: User.last.id))
      end
    end

    context 'with invalid attributes' do
      it 'redirect to new template if user was not save' do
        post :create, params: { user: attributes_for(:user_without_email) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST #qr_setup' do
    before do
      user.generate_token
      totp = ROTP::TOTP.new(user.token)
      @auth_code = totp.now
    end
  end
end
