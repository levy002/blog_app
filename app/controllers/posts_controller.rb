class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    if current_user.nil?
      redirect_to new_user_session_path
      return
    end
    @posts = if current_user.role?
               @user.posts.includes(:comments)
             else
               @user.posts.includes(:comments, :author)
             end
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @new_post = Post.new
  end

  def create
    puts params
    user = current_user
    new_post = Post.new(author: user, title: post_params['title'], text: post_params['text'])

    respond_to do |format|
      format.html do
        if new_post.save
          flash[:success] = 'Post created successfully'
          redirect_to user_posts_url(id: user.id)
        else
          flash.now[:error] = 'Error: Post could not be created'
          redirect_to new_user_post_url(user_id: user.id)
        end
      end
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def destroy
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @post.destroy
    redirect_to user_post_path(@user.id, @post.id)
  end
end
