get '/questions' do

  @questions = Question.order(created_at: :desc)


  erb :'questions/index'
end

get '/questions/new' do

  redirect '/questions' unless session[:user_id]

  erb :'questions/new'
end

post '/questions' do

  redirect '/questions' unless session[:user_id]

  @question = Question.create(
              title: params[:title],
              topic: params[:topic],
              content: params[:content],
              user_id: session[:user_id]
              )

  redirect '/questions'
end

get '/questions/:id' do

  @question = Question.find(params[:id])


  erb :'questions/show'
end

post '/questions/:id/vote' do
  question = Question.find(params[:id])

  question.votes.create(votable_id: params[:id], votable_type: "Question")
end