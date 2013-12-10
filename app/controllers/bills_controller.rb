class BillsController < ApplicationController
  before_action :signed_in_user
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  def show
    @bill_owner=User.find_by_id(@bill.user_id)
    @bill_members=User.where("id IN (SELECT user_id FROM bill_users WHERE bill_id = ?)",@bill.id)
  end

  def create
=begin
    @bill = current_user.bills.build(bill_params)
    if @bill.save
      flash[:success] = "Bill created!"
      @bill.user!(current_user)

      redirect_to @bill
    else
      @feed_items = []
      render 'static_pages/home'
    end
=end
    @users = User.where("id IN (SELECT user_id FROM members WHERE group_id = ?)",params[:bill][:group_id])
    bill_params[:comment]=params[:bill][:comment]
    bill_params[:amount]=params[:bill][:amount]
    @bill = current_user.bills.build(bill_params)
    if @bill.save
      flash[:success] = "Bill created"
      if @users.any?
        @users.each do |user|
          test =  BillUser.where("user_id = ? AND bill_id = ?",user.id,params[:bill][:bill_id])
          if test.any?
          else
            @bill.user!(user,@bill)
          end
        end
      end
    redirect_to @bill
    end  
  end

  def destroy
    @bill.destroy
    redirect_to root_path
  end

  def edit
    @id = params[:id]
  end

  def update
    if @bill.update(bill_params)
      redirect_to @bill, notice: 'The picture was successfully added to the bill.'
    else
      redirect_to @bill, notice: 'Problem while adding the picture'
    end
  end

  private

    def set_bill
      @bill = Bill.find(params[:id])
    end

    def bill_params
      params.require(:bill).permit(:comment, :amount, :ref) 
    end

    def correct_user
      @bill = current_user.bills.find_by(id: params[:id])
      redirect_to root_path if @bill.nil?
    end
end
