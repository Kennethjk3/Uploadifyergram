class UsersController < ApplicationController

  def index
    @users = User.all
    # respond_to do |format|
    #   format.html
    #   format.json do
    #     @users = User.all
    #     render json: @users
    #   end
    # end
  end

  def show
    find_user
  end

  def new
    @user = User.new
  end

  def edit
    find_user
  end

  def create
    @user = User.create(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'user was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to root_path }
    #     format.json { render json: {}, status: 201 }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user.errors, status: 422 }
    #   end
    # end
  end

  def update
    find_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    find_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end


  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
