class Backend::UsersController < Backend::ApplicationController
  respond_to :html

  before_filter only: 'create' do
    @user = User.new(params[:user], without_protection: true)
  end

  load_and_authorize_resource

  before_filter only: %w(update confirm) do
    @user.edited_by_admin = true
  end

  def index
    @users = @users.ordered.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @user.do_confirm = true

    redirect_to backend_user_path(@user), notice: t('was.created') and return if @user.save
    respond_with(@user)
  end

  def update
    updated = if params[:user]['password'].present?
      @user.update_with_password(params[:user], without_protection: true)
    else
      @user.update_without_password(params[:user], without_protection: true)
    end

    if updated
      sign_in @user, bypass: true if current_user == @user
      redirect_to backend_user_path(@user), notice: t('was.updated') and return
    end
    respond_with(@user)
  end

  def destroy
    @user.destroy
    flash[:notice] = t 'was.destroyed'
    respond_with(@user, location: backend_users_path)
  end

  def confirm
    redirect_to [:backend, @user], notice: t('was.confirmed') and return if @user.confirm!
    render 'show'
  end
end
