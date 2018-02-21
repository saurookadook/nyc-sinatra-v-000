class FiguresController < ApplicationController

  get '/figures' do
    erb :"figures/index"
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/new"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :"figures/show"
  end

  post '/figures' do
    @figure = Figure.find_or_create_by(name: params[:figure][:name])

    if !params[:figure][:title_ids].empty?
      @figure.title_ids = params[:figure][:title_ids]
    elsif !params[:title][:name].nil?
      @title = Title.find_or_create_by(name: params[:title][:name])
      @figure.title_ids << @title.id
      @title.figure = @figure
    end

    if !(params[:figure][:landmark_ids].nil?)
      @figure.landmark_ids = params[:figure][:landmark_ids]
    elsif !params[:landmark][:name].nil?
      binding.pry
      @landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
      @figure.landmark_ids << @landmark.id
      @landmark.figure = @landmark
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

end
