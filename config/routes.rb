ManybotsGmailMadpizza::Engine.routes.draw do

  match 'toggle' => 'madpizza#toggle', as: 'toggle'
  resource :madpizza
  resources :meals

  root to: 'madpizza#show'
  
end
