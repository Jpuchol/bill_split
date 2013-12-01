class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @bill = current_user.bills.build
      @feed_items = current_user.bills.paginate(page: params[:page])
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
