class BillUsersController < ApplicationController
  before_action :signed_in_user



  def create
    
  end

  def destroy
  end


  private

    def bill_user_params
      params.require(:bill).permit()
    end

=begin
    def correct_user
      @bill = current_user.bills.find_by(id: params[:id])
      redirect_to root_path if @bill.nil?
    end
=end
end