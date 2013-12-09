class GroupsController < ApplicationController
  before_action :signed_in_user
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
    @my_groups=current_user.group_feed.paginate(page: params[:page])
#    @groups = current_user.groups.paginate(page: params[:page])
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @users = User.all
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


  # POST /groups
  # POST /groups.json
  def create
    @group = current_user.groups.build(group_params)
    @group.user = current_user
    if @group.save
      @group.member!(current_user)
      flash[:success] = "Group created!"
      redirect_to mygrps_path
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
