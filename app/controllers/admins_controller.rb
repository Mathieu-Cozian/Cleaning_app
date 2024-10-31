class AdminsController < ApplicationController
  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
    @admin.build_user
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      @admin.user.is_admin = true
      if @admin.user.save
        flash[:notice] = "Client created successfully"
      else
        flash[:alert] = "Client created successfully, but user"
      end
      redirect_to admins_path
    else
      render :new
    end
  end

          # MANAGEMENT CLEANERS

  def management_cleaners
    @statuses = Cleaner.statuses.keys
    @cleaners = Cleaner.includes(:user)
    @cleaners = @cleaners.where(status: params[:status]) if params[:status].present?

    if params[:sort].present? && %w[first_name last_name email].include?(params[:sort])
      direction = params[:direction] == "desc" ? "desc" : "asc"
      @cleaners = @cleaners.joins(:user).order("users.#{params[:sort]} #{direction}")
    end

    respond_to do |format|
      format.html # for the initial page load
      format.turbo_stream
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:user_attributes => [:email, :password, :password_confirmation, :first_name, :last_name])
  end

end
