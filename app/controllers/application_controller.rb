class ApplicationController < ActionController::Base
  def current_user
    User.find(params[:id] || params[:user_id])
  end

  def all_users
    User.all
  end

  def current_post
    Post.find(params[:id] || params[:post_id])
  end
end
