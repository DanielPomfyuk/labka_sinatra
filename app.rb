require 'sinatra'
require 'sinatra/activerecord'

configure(:development){set :database, "sqlite:///blog.sqlite3"}
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



post '/sessions/new' do


  @user = User.where(email: params[:email]).first
  if @user && @user.password == params[:password]
      flash[:notice] = "You've been signed in successfully."
      session[:user_id] = @user.id
    
  else
    flash[:notice] = "There was a problem signing you in."
    redirect '/users/new'
  end

  redirect '/home'
end


get '/logout' do
  session[:user_id] = nil
  redirect '/'
end


get '/users/:id/addresses' do
	@user = User.find(params[:id])
	erb :addresses
end



get '/users/new' do
  erb :signup
end


post '/users/new' do
  User.create(params[:user])
  redirect '/'
end

post '/posts/new' do 
	Post.create(params[:post])
 #  Post.create(user_id:session[:user_id])
	

	redirect '/home'

end



puts "the user id is" +" "+ (Post.last.user_id).to_s



