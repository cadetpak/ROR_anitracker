Rails.application.routes.draw do

# DISPLAY index page
root 'users#index'

# REGISTER users
post '/register' => 'users#create'

# LOGIN users
post '/login' => 'users#login'

# DISPLAY Dashboard
get '/dashboard' => 'users#dashboard'

# LOGOUT users
delete '/users' => 'users#logout'

# ADD anime
post '/add' => 'users#add'

# DELETE anime
post '/delete' => 'users#delete'

# COMPLETE anime
post '/complete' => 'users#complete'

# WATCH anime
post '/watch' => 'users#watch'
end
