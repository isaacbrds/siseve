# spec/controllers/speakers_controller_spec.rb
require 'rails_helper'

RSpec.describe SpeakersController, type: :controller do

  let(:user) { User.create(email: "test@example.com", password: "password") }
  
  let(:valid_attributes) do
    {
      user_id: user.id
    }
  end

  let(:invalid_attributes) do
    {
      user_id: nil
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      sign_in user
      speaker = Speaker.create!(valid_attributes)
      get :show, params: { id: speaker.to_param }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      speaker = Speaker.create!(valid_attributes)
      sign_in user
      get :edit, params: { id: speaker.to_param }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Speaker' do
        sign_in user
        expect {
          post :create, params: { speaker: valid_attributes }
        }.to change(Speaker, :count).by(1)
      end

      it 'redirects to the created speaker' do
        sign_in user
        post :create, params: { speaker: valid_attributes }
        expect(response).to redirect_to(Speaker.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Speaker' do
        sign_in user
        expect {
          post :create, params: { speaker: invalid_attributes }
        }.to change(Speaker, :count).by(0)
      end

      it 'returns a success response (i.e., to display the "new" template)' do
        sign_in user
        post :create, params: { speaker: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:user) { User.create(email: "testa@example.com", password: "password") }
      let(:new_attributes) do
        {
          user_id: user.id
        }
      end

      it 'updates the requested speaker' do
        speaker = Speaker.create!(valid_attributes)
        sign_in user
        put :update, params: { id: speaker.to_param, speaker: new_attributes }
        speaker.reload
        expect(speaker.user_id).to eq(user.id)
      end

      it 'redirects to the speaker' do
        speaker = Speaker.create!(valid_attributes)
        sign_in user
        put :update, params: { id: speaker.to_param, speaker: new_attributes }
        expect(response).to redirect_to(speaker)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e., to display the "edit" template)' do
        speaker = Speaker.create!(valid_attributes)
        sign_in user
        put :update, params: { id: speaker.to_param, speaker: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  describe 'DELETE #destroy' do
    it 'destroys the requested speaker' do
      speaker = Speaker.create!(valid_attributes)
      sign_in user
      expect {
        delete :destroy, params: { id: speaker.to_param }
      }.to change(Speaker, :count).by(-1)
    end

    it 'redirects to the speakers list' do
      speaker = Speaker.create!(valid_attributes)
      sign_in user
      delete :destroy, params: { id: speaker.to_param }
      expect(response).to redirect_to(speakers_url)
    end
  end
end