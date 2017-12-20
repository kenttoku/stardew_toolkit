Rails.application.routes.draw do
  root 'tools#index'

  get 'tools/mines'

  resource :calendars do
  	post :up_year, :down_year, :up_season, :down_season
  end
end
