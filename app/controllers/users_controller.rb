class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :destroy]

  # GET /users
  # GET /users.json
  def index
#    @users = User.all
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    if current_user==@user
      redirect_to root_path
    else
      @bills = @user.bills.paginate(page: params[:page])
    end 
    @my_bills=Bill.where("(user_id = ?) AND (id IN (SELECT bill_id FROM bill_users WHERE user_id = ? AND validate = 'f'))",current_user.id,params[:id])
    @ows_me=0
    @owe_him=0
    @my_bills.each do |bill|
      members=BillUser.find_all_by_bill_id(bill.id)
      @ows_me+=bill.amount/members.count
    end
    @his_bills=Bill.where("(user_id = ?) AND (id IN (SELECT bill_id FROM bill_users WHERE user_id = ? AND validate = 'f'))",params[:id],current_user.id)
    @his_bills.each do |bill|
      members=BillUser.find_all_by_bill_id(bill.id)
      @owe_him+=bill.amount/members.count
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
#    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create    
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Bill split!"
      redirect_to @user
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
#    @user = User.find(params[:id])
    
    unless user_params[:image].nil?
      @pic = User.find(params[:id])
      @pic.imag.remove!
    end
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @pic = User.find(params[:id])
    @pic.imag.remove! 
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_path
  end
#  def destroy
#    @user.destroy
#    respond_to do |format|
#      format.html { redirect_to users_url }
#      format.json { head :no_content }
#    end
#  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :imag)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
