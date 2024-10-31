class CleanersController < ApplicationController
  def index
    @cleaners = Cleaner.all
  end

  def new
    @cleaner = Cleaner.new
    @cleaner.build_user
  end

  def create
    @cleaner = Cleaner.new(cleaner_params)
    if @cleaner.user.present?
      existing_user = User.find_by(email: @cleaner.user.email)
      if existing_user
        @cleaner.user = existing_user
        @cleaner.user.is_cleaner = true
      else
        @cleaner.user.is_cleaner = true
      end
    end

    if @cleaner.save
      flash[:notice] = "Cleaner created successfully"
      redirect_to cleaners_path
    else
      render :new
    end
  end
  private

  def cleaner_params
    params.require(:cleaner).permit(:user_attributes => [:email, :password, :password_confirmation, :first_name, :last_name])
  end
end
