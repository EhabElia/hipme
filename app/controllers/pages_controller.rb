class PagesController < ApplicationController
  def home
    @user_signed_in = false
  end
end
