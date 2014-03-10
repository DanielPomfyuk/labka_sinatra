require 'sinatra'
require 'sinatra/activerecord'

configure(:development){set :database, "sqlite:///my_app.sqlite3"}
set :sessions, true

require './models'


require 'bundler/setup' 
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep => true



def current_user
  if session[:user_id]
    User.find(session[:user_id])  
  else
    nil
  end
end



get '/' do
  erb :sign_in
end

get '/home' do
  @user = current_user
  erb :home
end

get '/profile' do 
  @user = current_user
  erb :profile
end

post '/sessions/new' do

  @user = User.where(email: params[:email]).first
  if @user && @user.password == params[:password]
      flash[:notice] = "You've been signed in successfully."
      session[:user_id] = @user.id
    
  else
    flash[:alert] = "There was a problem signing you in."
    redirect '/users/new'
  end

  redirect '/home'

end


get '/logout' do
  session[:user_id] = nil
  redirect '/'
end



get '/users/new' do
  erb :signup
end


post '/users/new' do
  User.create(params[:user])
  redirect '/'
end


post '/posts/new' do 
	Post.create(title:params[:title], content:params[:content], user_id:current_user.id)
	redirect '/home'

end

post '/profile/new' do 
  Profile.create(gender:params[:gender], location:params[:location], interest:params[:interest], user_id:current_user.id)
end






