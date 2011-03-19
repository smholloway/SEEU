Seeu::Application.routes.draw do

  # RESTful routes
  resources :manufacturers do
    resources :models
  end

  resources :rules

  resources :actuators do
	  resource :commands
  end

  resources :sensors do
	  resources :readings
  end

  # routes that retrieve information about sensors and actuators via JSON
  match '/sensors/:id/valid_values' => 'sensors#valid_values'
  match '/sensors/:id/valid_values_string' => 'sensors#valid_values_string'
  match '/sensors/get_id_from_name/:name' => 'sensors#get_id_from_name'
  match '/sensors/get_values_from_name/:name' => 'sensors#get_values_from_name'
  match '/sensors/get_values_string_from_name/:name' => 'sensors#get_values_string_from_name'

  match '/actuators/:id/valid_values' => 'actuators#valid_values'
  match '/actuators/:id/valid_values_string' => 'actuators#valid_values_string'
  match '/actuators/get_values_from_name/:name' => 'actuators#get_values_from_name'

  # machine readable page (only the command--no additional markup)
  match '/actuators/:id/command' => 'commands#command'

  # feedback and about
  match 'feedback', :to => 'home#feedback', :as => 'feedback'
  match 'about', :to => 'home#about', :as => 'about'
  match 'study', :to => 'home#study', :as => 'study'

  # set the document root to app/view/home/index.html.erb
	root :to => "home#index"

  # route all invalid URLs to document root
  match '*a' => redirect('/') # send all random routes to root
end
