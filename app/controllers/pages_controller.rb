class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @user_signed_in = false
  end
end
