class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @bill = current_user.bills.build
      @users = User.all
      @feed_items = current_user.bills.paginate(page: params[:page])
      @bill_items = current_user.feed.paginate(page: params[:page])
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
