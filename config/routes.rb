Drafty::Application.routes.draw do
  resources :drafts

  resources :players
  resources :teams

  match 'assignment' => 'players#assignment'
  match 'round' => 'players#round'

  match 'admin' => 'admin#index'
  match 'start_draft_clock' => 'admin#start_draft_clock', :via => :post
  match 'stop_draft_clock' => 'admin#stop_draft_clock', :via => :post

  root :to => "players#index"
end
