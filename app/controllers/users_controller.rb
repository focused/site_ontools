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
end
