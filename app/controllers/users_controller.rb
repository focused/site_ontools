class UsersController < ApplicationController
  respond_to :html

  load_and_authorize_resource

  def index
    # @users = @users.ordered.all
  end

  def show
    respond_with(@user)
  end

  def new
  end

  def edit
  end

  # accupied by devise ???
  # def create
  # end

  def update
  end

  def destroy
    @user.destroy
    flash[:notice] = t 'was.destroyed'
    respond_with(@user)
  end

  def confirm
    @user = User.find(params[:id])
    @user.confirm!
    redirect_to @user, notice: t('was.confirmed') and return if @user.save
  end

  def update_spirit
    respond_to do |format|
      if @user.update_attribute(:spirit, params[:user][:spirit])
        format.js
      else
        format.js
      end
    end
  end
end
