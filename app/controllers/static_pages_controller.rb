class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @bill = current_user.bills.build
    end
  end

  def about
  end

  def blog
  end

  def help
  end

  def api
  end
end
