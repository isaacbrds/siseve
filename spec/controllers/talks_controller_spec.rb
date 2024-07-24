require 'rails_helper'

RSpec.describe TalksController, type: :controller do
  let(:user) { User.create(email: "test@example.com", password: "password") }
  let(:event) { Event.create(name: "Evento Teste", description: "Descrição do evento teste", local: "Local do evento", start_date: "2024-07-18 10:00:00", end_date: "2024-07-18 12:00:00") }
  let(:speaker){ Speaker.create(user: user) }
  let(:valid_attributes) do
    {
      name: "Talk Teste",
      description: "Descrição do talk teste",
      event_id: event.id,
      speaker_id: speaker.id,
      start_date: "2024-07-18 10:00:00",
      end_date: "2024-07-18 11:00:00"
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      description: nil,
      event_id: nil,
      speaker_id: nil,
      start_date: nil,
      end_date: nil
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: { event_id: event.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      talk = Talk.create!(valid_attributes)
      get :show, params: { event_id: event.id, id: talk.to_param }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      sign_in user
      get :new, params: { event_id: event.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      talk = Talk.create!(valid_attributes)
      sign_in user
      get :edit, params: { event_id: event.id, id: talk.to_param }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Talk' do
        sign_in user
        expect {
          post :create, params: { event_id: event.id, talk: valid_attributes }
        }.to change(Talk, :count).by(1)
      end

      it 'redirects to the created talk' do
        sign_in user
        post :create, params: { event_id: event.id, talk: valid_attributes }
        expect(response).to redirect_to([event, Talk.last])
      end
    end

    context 'with invalid params' do
      it 'does not create a new Talk' do
        sign_in user
        expect {
          post :create, params: { event_id: event.id, talk: invalid_attributes }
        }.to change(Talk, :count).by(0)
      end

      it 'returns a success response' do
        sign_in user
        post :create, params: { event_id: event.id, talk: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: "Talk Atualizado",
          description: "Descrição do talk atualizado",
          start_date: "2024-07-18 11:00:00",
          end_date: "2024-07-18 12:00:00"
        }
      end

      it 'updates the requested talk' do
        talk = event.talks.create!(valid_attributes)
        sign_in user
        put :update, params: { event_id: event.id, id: talk.to_param, talk: new_attributes }
        talk.reload
        expect(talk.name).to eq("Talk Atualizado")
      end

      it 'redirects to the talk' do
        talk = event.talks.create!(valid_attributes)
        sign_in user
        put :update, params: { event_id: event.id, id: talk.to_param, talk: new_attributes }
        expect(response).to redirect_to([event, talk])
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e., to display the "edit" template)' do
        talk = event.talks.create!(valid_attributes)
        sign_in user
        put :update, params: { event_id: event.id, id: talk.to_param, talk: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested talk' do
      talk = event.talks.create!(valid_attributes)
      sign_in user
      expect {
        delete :destroy, params: { event_id: event.id, id: talk.to_param }
      }.to change(Talk, :count).by(-1)
    end

    it 'redirects to the talks list' do
      talk = event.talks.create!(valid_attributes)
      sign_in user
      delete :destroy, params: { event_id: event.id, id: talk.to_param }
      expect(response).to redirect_to(event_talks_url(event))
    end
  end
end