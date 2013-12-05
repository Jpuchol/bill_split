class MembersController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:member][:user_id])
    current_user.member!(@user)
    redirect_to @group
  end


  def destroy
    @user = Member.find(params[:id])
    current_user.unmember!(@user)
    redirect_to @group
  end
end
