class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :utilisateur_admin , only: :destroy

  def show
    @user = User.find(params[:id])
  end

  def index
    @user = User.paginate(:page => params[:page], :per_page => 4)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)   # Not the final implementation!
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
      if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Utilisateur supprimé."
    redirect_to users_url
  end
  

  def user_params
      params.require(:user).permit(:user_type, :nom, :prenom, :etablissement, :identifiant,:date , :email, :password,
                                   :password_confirmation)
  end

  def logged_in_user
      unless logged_in?
        flash[:danger] = "Veuillez vous connecter !"
        redirect_to root_url
      end
  end

  def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
      flash[:danger] = "Accès refusé !"
      redirect_to(root_url)
      end
  end

  private
    def utilisateur_admin
      @user = User.find(params[:id])
      if not current_user.admin? || @user ==  current_user
        redirect_to(root_url)
      end
    end
end