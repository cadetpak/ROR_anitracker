class UsersController < ApplicationController

# DISPLAY index page
def index
  # automatically looks & loads index.html.erb
end

# REGISTER user
def create
  @user = User.new(user_params)
  if @user.save
  	flash[:message] = ["Successfully Registered, Please Log In!"]
  	redirect_to '/'
  else
  	flash[:message] = @user.errors.full_messages
  	redirect_to '/'
  end
end

# LOGIN user
def login
  @user = User.find_by_email(params[:email])
  if @user && @user.authenticate(params[:password])
  	# SESSION ID is set here
  	session[:id] = @user.id
  	redirect_to '/dashboard'
  else
  	flash[:message] = ["Email & Password Did Not Match Records!"]
  	redirect_to :back
  end
end

# LOGOUT user
def logout
  session[:id] = nil
  redirect_to '/'
end

# DISPLAY dashboard
def dashboard
  # current_user is method found in application_controller.rb
  # @user becomes variable accessible in dashboard.html.erb
  @user = User.find(current_user.id)
  @current = Anime.where(user:User.find(current_user.id), status:1).order('title ASC')
  @want = Anime.where(user:User.find(current_user.id), status:2).order('title ASC')
  @complete = Anime.where(user:User.find(current_user.id), status:3).order('title ASC')
end

# ADD anime
def add
  @anime = Anime.new(title: params[:title], status: params[:status], user: User.find(current_user.id))
  if @anime.save
    redirect_to '/dashboard'
  else
    flash[:message] = @anime.errors.full_messages
    redirect_to '/dashboard'
  end
end

# DELETE anime
def delete
  Anime.find(params[:id]).destroy
  redirect_to '/dashboard'
end

# COMPLETE anime
def complete
  Anime.find(params[:update_id]).update(status: 3)
  redirect_to '/dashboard'
end

# WATCHING anime
def watch
  Anime.find(params[:watching_id]).update(status: 1)
  redirect_to '/dashboard'
end


private
def user_params
  params.require(:user).permit(:alias, :email, :password, :password_confirmation)
  # requiring password_confirmation automatically flashes error if password_confirmation field does not match
end

end
