class UsersController < ApplicationController
  before_action :get_user, except: [:index,:new,:create]
  #respond_to :html, :json

  def index
    @users = User.all
    respond_to do |format|
      format.json {render :json => @users.as_json}
      format.html
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.json {render :show, status: :created, location: @user}
        format.html {redirect_to @user, notice: 'User successfully created!'}
      else
        format.json {render @user.errors, status: :unprocessable_entity}
        format.html {render :new}
      end
    end
  end

  def show
    #respond_to(@user.as_json)
  end

  def update
    if @user.update_attributes(user_params)
      render json: @user.as_json, status: :ok
    else
      render json: {user: @user.error, status: :unprocessable_entity}
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:name,:email)
  end

  def get_user
    @user = User.find(params[:id])
    render json: {status: :not_found} unless @user
  end
end
