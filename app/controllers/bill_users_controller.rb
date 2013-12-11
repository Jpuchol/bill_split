class BillUsersController < ApplicationController
  before_action :signed_in_user
  before_action :set_bill_user, only: [:show, :edit, :update, :destroy]



  def create
    @users = User.where("id IN (SELECT user_id FROM members WHERE group_id=:my_group_id)",my_group_id: params[:data][:group_id])
    @bill = Bill.find(params[:data][:bill_id])
    if @users.any?
      @users.each do |user|
        test =  BillUser.where("user_id = ? AND bill_id = ?",params[:data][:bill_id],user.id)
        unless test.any?
          @bill.user!(user)
        end
      end
    end
    flash[:success] = "Group created!"
    redirect_to @bill
  end

  def destroy
  end

  def edit
  end

  def update
    if @bill_user.update(bill_user_params)
      bill = Bill.find_by(id: @bill_user.bill_id)
      redirect_to bill, notice: 'User has paid'
    end
  end


  private

    def set_bill_user
      @bill_user = BillUser.find(params[:id])
    end

    def bill_user_params
      params.require(:bill_user).permit(:validate)
    end

=begin
    def correct_user
      @bill = current_user.bills.find_by(id: params[:id])
      redirect_to root_path if @bill.nil?
    end
=end
end