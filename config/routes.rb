Rails.application.routes.draw do
  #get 'automata/index'
  
  # Ajax request for generating a random automaton
  post 'automata/random', to: 'automata#random'
  post 'automata/draw', to: 'automata#draw'
  post 'automata/transform', to: 'automata#transform'

  # From the devise registrations functionality, we want only the edit and
  # delete account functionality, but not the sign up one. We exclude the whole
  # registrations at once and then add manually the routes we want.
  devise_for :users, skip: :registrations
  as :user do
    get '/users/cancel' => 'devise/registrations#cancel', :as => 'cancel_user_registration'
    get '/users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put '/users' => 'devise/registrations#update', :as => 'user_registration'
    patch '/users' => 'devise/registrations#update'
  end
  
  # GET '/' for unauthenticated users
  unauthenticated do
    devise_scope :user do
      root to: "devise/sessions#new", as: "unauthenticated_root"
    end
  end

  # GET '/' for authenticated users
  root to: "automata#index", as: "authenticated_root"

end