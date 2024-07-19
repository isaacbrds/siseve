# spec/controllers/events_controller_spec.rb
require 'rails_helper'


RSpec.describe EventsController, type: :controller do
  let(:user) {  
    User.create(
        name: 'João',
        email: 'joao@example.com',
        password: 'password'
      )
  }

  let(:valid_attributes) do
    {
      name: "Evento Teste",
      description: "Descrição do evento teste",
      local: "Local do evento",
      start_date: "2024-07-18 10:00:00",
      end_date: "2024-07-18 12:00:00"
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      description: nil,
      local: nil,
      start_date: nil,
      end_date: nil
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      #expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
      
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      event = Event.create!(valid_attributes)
      get :show, params: { id: event.to_param }
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
      event = Event.create!(valid_attributes)
      sign_in user
      get :edit, params: { id: event.to_param }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Event' do
        sign_in user
        expect {
          post :create, params: { event: valid_attributes }
        }.to change(Event, :count).by(1)
      end

      it 'redirects to the created event' do
        sign_in user
        post :create, params: { event: valid_attributes }
        expect(response).to redirect_to(Event.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Event' do
        sign_in user
        expect {
          post :create, params: { event: invalid_attributes }
        }.to change(Event, :count).by(0)
      end

      it 'returns a success response (i.e., to display the "new" template)' do
        sign_in user
        post :create, params: { event: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: "Evento Atualizado",
          description: "Descrição do evento atualizado",
          local: "Local do evento atualizado",
          start_date: "2024-07-19 10:00:00",
          end_date: "2024-07-19 12:00:00"
        }
      end

      it 'updates the requested event' do
        event = Event.create!(valid_attributes)
        sign_in user
        put :update, params: { id: event.to_param, event: new_attributes }
        event.reload
        expect(event.name).to eq("Evento Atualizado")
      end

      it 'redirects to the event' do
        event = Event.create!(valid_attributes)
        sign_in user
        put :update, params: { id: event.to_param, event: new_attributes }
        expect(response).to redirect_to(event)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e., to display the "edit" template)' do
        event = Event.create!(valid_attributes)
        sign_in user
        put :update, params: { id: event.to_param, event: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested event' do
      event = Event.create!(valid_attributes)
      sign_in user
      event.save
      expect {
        delete :destroy, params: { id: event.to_param }
      }.to change(Event, :count).by(-1)
    end

    it 'redirects to the events list' do
      event = Event.create!(valid_attributes)
      sign_in user
      delete :destroy, params: { id: event.to_param }
      expect(response).to redirect_to(events_url)
    end
  end
end
