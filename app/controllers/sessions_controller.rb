class SessionsController < ApplicationController
  before_action :authenticate, except: [:create, :login, :new]

  def authenticate
    if !session['current_user']
      redirect_to '/'
    end
  end

  def application
    @secrets = Secret.all
    if !session['current_user']
      redirect_to '/'
    end
  end

  def new
  end

  def login
    @user = User.find_by_email(params['user']['email']).try(:authenticate, params['user']['password'])
    if @user
      session[:current_user] = @user
      redirect_to '/sessions/application'
    else
      redirect_to '/'
    end
  end
  def create
    User.create(user_params).try(:authenticate, params['password'])
    redirect_to '/'
  end

  def destroy
    if session['current_user']['id'].to_s == params[:id]
      User.destroy(params[:id])
      session.clear
    end
    redirect_to '/'
  end

  def logout
    session.clear
    redirect_to '/'
  end

  def edit
  if session['current_user']['id'].to_s == params[:id]
    @user = User.find(params[:id])
  else
    redirect_to '/sessions/application'
  end
  end

  def update
    if session['current_user']['id'].to_s == params[:id]
      User.update(params[:id], name:params['user']['name'], email:params['user']['email'])
    end
    redirect_to '/sessions/edit/' + params[:id].to_s
  end

  def create_secret
    Secret.create(secret_params)
    redirect_to '/sessions/application'
  end

  def delete_secret
    secret = Secret.find(params[:id])
    if session['current_user']['id'] == secret['user_id']
    Secret.destroy(params[:id])
    end
    redirect_to '/sessions/application'
  end

  def dash
    @secrets = Secret.all
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def secret_params
    params.require(:secret).permit(:content, :user_id)
  end
end
