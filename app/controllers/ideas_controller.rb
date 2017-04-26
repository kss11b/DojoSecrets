class IdeasController < ApplicationController
    before_action :authenticate, except: [:create, :login, :new]
  def authenticate
    if !session['current_user']
      redirect_to '/'
    end
  end

  def dash
    @ideas = Idea.all
  end

  def new
  end

  def login
    @user = User.find_by_email(params['user']['email']).try(:authenticate, params['user']['password'])
    if @user
      session[:current_user] = @user
      redirect_to '/ideas/dash'
    else
      flash[:errors]=["Invalid Login"]
      redirect_to '/'
    end
  end
  def create
    if params['user']['password'] == ''
          flash[:errors]=["Fill in password field"]
    elsif User.create(user_params).try(:authenticate, params['user']['password'])
      if User.create(user_params)
        flash[:errors]=["Success"]
      else
        flash[:errors]=["Invalid Create"]
    else
      flash[:errors]=["Invalid Create"]
    end
    redirect_to '/'
  end

  def logout
    session.clear
    redirect_to '/'
  end

  def create_idea
    Idea.create(idea_params)
    redirect_to '/ideas/dash'
  end

  def delete_idea
    idea = Idea.find(params[:id])
    if session['current_user']['id'] == idea['user_id']
    Idea.destroy(params[:id])
    end
    redirect_to '/ideas/dash'
  end

  def create_like

    Like.create(like_params)

    redirect_to '/ideas/dash'
  end

  def destroy_like
    this_like = Like.where(user_id: params[:id], idea_id: params[:id2])
    if session['current_user']['id'].to_s == params[:id]
      Like.destroy(this_like.map(&:id))
    end
    redirect_to '/ideas/dash'
  end

  def show_user
    @user = User.find(params[:id])
    @ideas = Idea.where(user_id: params[:id])
    @idea_count = @ideas.count
    @likes = Like.where(user_id: params[:id])
    @likes_count = @likes.count
  end

  def show_idea
    @idea = Idea.find(params[:id])
  end
  private
  def user_params
    params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation)
  end

  def idea_params
    params.require(:idea).permit(:content, :user_id)
  end

  def like_params
    params.require(:like).permit(:user_id, :idea_id)
  end
end
