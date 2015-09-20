post '/comments' do

  # redirect "/login" unless session[:user_id]
  @user = User.find(session[:user_id])

  redirect "/questions/#{params[:question_id]}" if params[:content].nil?

  comment = Comment.create(
              content: params[:content],
              question_id: params[:question_id],
              user_id: session[:user_id]
             )

  if request.xhr?
    {content: params[:content], user: comment.user.username, id: comment.id}.to_json
  end

end

post '/comments/:id/vote' do
  comment = Comment.find(params[:id])
  comment.votes.create(votable_id: params[:id], votable_type: "Comment")

  {votes: comment.votes.count, id: params[:id]}.to_json
end
