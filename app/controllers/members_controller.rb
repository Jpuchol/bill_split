class MembersController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:member][:user_id])
    @group = Group.find(params[:member][:group_id])
    @group.member!(@user)
    redirect_to @group
    
  end


  def destroy
    @user = Member.find(params[:id])
    current_user.unmember!(@user)
    redirect_to @group
  end

  private 
    def members_params
    params.require(:user).permit(:user_id)
    end

end
