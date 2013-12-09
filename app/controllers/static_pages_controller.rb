class StaticPagesController < ApplicationController
  def home
    if signed_in?
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
