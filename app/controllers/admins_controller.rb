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
    # Get list of statuses for filtering
    @statuses = Cleaner.statuses.keys

    # Eager load associated user records to optimize queries
    @cleaners = Cleaner.includes(:user)

    # Apply status filter if provided
    @cleaners = @cleaners.where(status: params[:status]) if params[:status].present?

    # Apply sorting if the parameters are valid
    if params[:sort].present? && %w[first_name last_name email].include?(params[:sort]) && params[:direction].present?
      # Debugging to check sort parameters
      p params[:sort]
      p params[:direction]

      # Apply sorting based on user attributes
      @cleaners = @cleaners.joins(:user).order("users.#{params[:sort]} #{params[:direction]}")
    end

    # Render in response to both HTML and Turbo Stream
    respond_to do |format|
      format.html # for initial page load
      format.turbo_stream
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:user_attributes => [:email, :password, :password_confirmation, :first_name, :last_name])
  end

end
