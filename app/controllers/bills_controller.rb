class BillsController < ApplicationController
  before_action :signed_in_user


  def create
    @bill = current_user.bills.build(bill_params)
    if @bill.save
      flash[:success] = "Bill created!"
      @bill.user!(current_user)
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
=begin
  @group = current_user.groups.build(group_params)
    @group.user = current_user
    if @group.save
      @group.member!(current_user)
      flash[:success] = "Group created!"
      redirect_to mygrps_path
    else
      render 'new'
    end
=end

  def destroy
    @bill = current_user.bills.find(params[:id])
    @bill.destroy
    redirect_to root_path
  end

  private

    def bill_params
      params.require(:bill).permit(:comment, :amount)
    end

    def correct_user
      @bill = current_user.bills.find_by(id: params[:id])
      redirect_to root_path if @bill.nil?
    end
end
