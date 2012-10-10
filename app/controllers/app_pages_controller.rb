class AppPagesController < ApplicationController
  respond_to :html
  layout false, only: 'home_stub'

  def home

  end

  def home_stub
  end

end
