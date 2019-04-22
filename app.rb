require 'sinatra'
require 'sinatra/activerecord'

configure(:development){set :database, {adapter: "sqlite3", database: "my_app.sqlite3"}}
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
  if !current_user
    redirect '/'
  else
    @user = current_user
    erb :home
  end
end

get '/profile' do
  if current_user
  @user = current_user
  @messages = current_user.messages
  erb :profile
  else
    redirect '/'
  end
end
post '/users/send_message/:reciever_id' do
  @user = User.find(params[:reciever_id])
  a = Message.new(sender_id:current_user.id,user_id:params[:reciever_id],message_body:params[:message_body])
  @user.messages.push(a)
  redirect '/'
end

post '/sessions/new' do

  @user = User.where(email: params[:email]).first
  if @user && @user.password == params[:password]
      flash[:notice] = "You've been signed in successfully."
      session[:user_id] = @user.id
  else
    flash[:alert] = "There was a problem signing you in."
    redirect '/'
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

get '/only_friends' do
  @friends = current_user.users
  erb :home
end

post '/users/new' do
  User.create(params[:user])
  redirect '/'
end

post '/users/follow/:id' do
  current_user.users.push(User.find(params[:id]))
  redirect '/home'
end
post '/users/unfollow/:id' do
  current_user.users.delete(User.find(params[:id]))
  redirect '/home'
end
post '/posts/new' do 
	Post.create(title:params[:title], content:params[:content], user_id:current_user.id)
  @messages = current_user.messages
  redirect '/home'
end

post '/profile/new' do 
  Profile.create(gender:params[:gender], location:params[:location], interest:params[:interest], user_id:current_user.id)
end






