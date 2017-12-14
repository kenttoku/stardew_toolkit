Rails.application.routes.draw do
  root 'tools#index'

  get 'tools/mines'
end
