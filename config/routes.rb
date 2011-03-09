Seeu::Application.routes.draw do

  resources :manufacturers do
    resources :models
  end

#  resources :rules
#	match 'rules/playing' => 'rules#playing'
	resources :rules do
		member do
			get 'playing'
		end
	end

  resources :actuators do
	  resource :commands
  end

  resources :sensors do
	  resources :readings
  end

  resources :home do
	resources :test
  end

  match '/sensors/:id/valid_values' => 'sensors#valid_values'
  match '/sensors/:id/valid_values_string' => 'sensors#valid_values_string'
  match '/sensors/get_id_from_name/:name' => 'sensors#get_id_from_name'
  match '/sensors/get_values_from_name/:name' => 'sensors#get_values_from_name'
  match '/sensors/get_values_string_from_name/:name' => 'sensors#get_values_string_from_name'

  match '/actuators/:id/valid_values' => 'actuators#valid_values'
  match '/actuators/:id/valid_values_string' => 'actuators#valid_values_string'
  match '/actuators/get_values_from_name/:name' => 'actuators#get_values_from_name'

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

	root :to => "home#index"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
