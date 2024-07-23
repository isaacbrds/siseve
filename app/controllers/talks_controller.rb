# app/controllers/talks_controller.rb
class TalksController < ApplicationController
    before_action :set_event
    before_action :authenticate_user! , except: [:index, :show]
    before_action :set_talk, only: [:show, :edit, :update, :destroy]
  
    def index
      @talks = @event.talks
    end
  
    def show
    end
  
    def new
      @talk = @event.talks.build
    end
  
    def create
      @talk = @event.talks.build(talk_params)
      if @talk.save
        redirect_to event_talk_path(@event, @talk), notice: 'Talk foi criado com sucesso.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
    end
  
    def update
      if @talk.update(talk_params)
        redirect_to event_talk_path(@event, @talk), notice: 'Talk foi atualizado com sucesso.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @talk.destroy
      redirect_to event_talks_path(@event), notice: 'Talk foi excluído com sucesso.'
    end
  
    private
  
    def set_event
      @event = Event.find(params[:event_id])
    end
  
    def set_talk
      @talk = @event.talks.find(params[:id])
    end

    def set_speaker
      @speaker = Speaker.create(user_id: user_id, talk_id: talk_id)
    end
  
    def talk_params
      params.require(:talk).permit(:name, :description, :end_date, :start_date, :user_id)
    end
  end
  