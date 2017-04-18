class LikesController < ApplicationController

before_action :authenticate
  def authenticate
    if !session['current_user']
      redirect_to '/'
    end
  end
  def create

    Like.create(like_params)

    redirect_to '/sessions/dash'
  end

  def destroy
    this_like = Like.where(user_id: params[:id], secret_id: params[:id2])
    if session['current_user']['id'].to_s == params[:id]
      Like.destroy(this_like.map(&:id))
    end
    redirect_to '/sessions/dash'
  end
  private

  def like_params
    params.require(:like).permit(:user_id, :secret_id)
  end
end
