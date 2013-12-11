class GroupsController < ApplicationController
  before_action :signed_in_user
  before_action :set_group, only: [:show, :edit, :update, :destroy, :add]

  # GET /groups/1
  # GET /groups/1.json
  def show
    @users = User.all
    @group_users = User.where("id IN (SELECT user_id FROM members WHERE group_id = ? )",params[:id])
    @group = Group.find(params[:id])
    @bill = current_user.bills.build
    @bill_user = current_user.bill_users.build
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  def add
    @users = User.all
    
  end


  # POST /groups
  # POST /groups.json
  def create
    @group = current_user.groups.build(group_params)
    @group.user = current_user
    if @group.save
      @group.member!(current_user)
      flash[:success] = "Group created!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    redirect_to root_path
  end



  private

    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :owner, :comment)
    end
end
