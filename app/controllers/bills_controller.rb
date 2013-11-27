class BillsController < ApplicationController
  before_action :signed_in_user

  def create
    @bill = current_user.bills.build(bill_params)
    if @bill.save
      flash[:success] = "Bill created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @bill.destroy
    redirect_to root_path
  end

  private

    def bill_params
      params.require(:bill).permit(:comment)
    end

    def correct_user
      @bill = current_user.bills.find_by(id: params[:id])
      redirect_to root_path if @bill.nil?
    end
end
