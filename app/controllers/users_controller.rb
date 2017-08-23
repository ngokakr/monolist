class UsersController < ApplicationController
  def show
    @user = User.find(user_params)
    
    if @user.save
      flash[:success] = "ユーザーを登録しました。"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザーの登録に失敗しました。"
      render :new
    end
  end

  def new
    @user = User.new
  end

  def create
    
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
