class AppPagesController < ApplicationController
  respond_to :html
  layout false, only: 'home'

  def home
  end

  def home_stub
  end

end
