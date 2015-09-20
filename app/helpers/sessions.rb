helpers do

  def current_user
    !session[:user_id].nil?
  end

end
