get '/' do
  redirect '/questions'
end

get '/login' do
  erb :login, layout: false
end

post '/login' do
  user = User.find_by_email(params[:email])

  if user.nil?
    redirect '/login'
  elsif user.password == params[:password]
    session[:user_id] = user.id
    redirect "/questions"
  else
    redirect '/login'
  end
end

get '/users/new' do
  erb :signup, layout: false
end

post '/users' do
  user = User.new(params)
  if user.save
    session[:user_id] = user.id
    redirect "/questions"
  else
    redirect "/users/new"
  end
end


get '/logout' do

  session[:user_id] = nil

  redirect '/questions'
end







