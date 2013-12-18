class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @feed_items = current_user.bills.paginate(page: params[:page])
      @bill_items = current_user.feed.paginate(page: params[:page])
      @users = User.all
      #@user_bills = current_user.feed.pluck("DISTINCT user_id")
      @mygroups = Group.where("id IN (SELECT group_id FROM members WHERE user_id = ?)",current_user.id)
#      @user_bills = current_user.feed.pluck("DISTINCT user_id")
    end
  end

  def money
    #People who owe me
    bills=BillUser.where("bill_id IN (SELECT id FROM bills WHERE user_id=? AND validate = 'f')",current_user.id)
    @owe_me=Hash.new
    bills.each do |bill|
      unless bill.user_id == current_user.id
        mybill=Bill.find_by_id(bill.bill_id)
        bill_members=User.where("id IN (SELECT user_id FROM bill_users WHERE bill_id = ?)",bill.bill_id)
        unless mybill.nil?
          
          user=User.find_by_id(bill.user_id)
          if @owe_me["#{bill.user_id}"].nil?
            @owe_me["#{bill.user_id}"]=Hash.new
            @owe_me["#{bill.user_id}"]["amount"]=mybill.amount/bill_members.count
          else 
            @owe_me["#{bill.user_id}"]["amount"]+=mybill.amount/bill_members.count
          end
          @owe_me["#{bill.user_id}"]["name"]=user.name
        end
      end
    end

    #People I owe
    bills=BillUser.find_all_by_user_id(current_user.id)
    @owe=Hash.new
    bills.each do |bill|
      bill_detail=Bill.find_by_id(bill.bill_id)
      unless bill_detail.user_id == current_user.id
        bill_members=User.where("id IN (SELECT user_id FROM bill_users WHERE bill_id = ?) AND validate = 'f'",bill.bill_id)
        unless bill_detail.nil?
          user=User.find_by_id(bill_detail.user_id)
          if @owe["#{bill_detail.user_id}"].nil?
            @owe["#{bill_detail.user_id}"]=Hash.new
            @owe["#{bill_detail.user_id}"]["amount"]=bill_detail.amount/bill_members.count
          else
            @owe["#{bill_detail.user_id}"]["amount"]+=bill_detail.amount/bill_members.count
          end
          @owe["#{bill_detail.user_id}"]["name"]=user.name
        end
      end
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
