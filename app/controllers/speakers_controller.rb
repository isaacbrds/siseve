# app/controllers/speakers_controller.rb
class SpeakersController < ApplicationController
  before_action :set_speaker, only: [:show, :edit, :update, :destroy]

  def index
    @speakers = Speaker.all
  end

  def show
  end

  def new
    @speaker = Speaker.new
  end

  def edit
  end

  def create
    @speaker = Speaker.new(speaker_params)
    if @speaker.save
      redirect_to @speaker, notice: 'Speaker was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @speaker.update(speaker_params)
      redirect_to @speaker, notice: 'Speaker was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @speaker.destroy
    redirect_to speakers_url, notice: 'Speaker was successfully destroyed.'
  end

  private

  def set_speaker
    @speaker = Speaker.find(params[:id])
  end

  def speaker_params
    params.require(:speaker).permit(:user_id)
  end
end
