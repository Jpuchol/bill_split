class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @feed_items = current_user.bills.paginate(page: params[:page])
      @bill_items = current_user.feed.paginate(page: params[:page])
      @users = User.all
      @user_bills = current_user.feed.pluck("DISTINCT user_id")
    end
  end

  def about
  end

  def blog
  end

  def help
  end

  def signup
  end

  def signin
  end

  def change
  end

  def createBill
  end

  def createGroup
  end

  def remove
  end

  def manage
  end

  def addUser
  end
end
