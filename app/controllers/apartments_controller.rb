class ApartmentsController < ApplicationController
  def index
    @apartments = Apartment.all
  end

  def new
    @apartment = Apartment.new
  end

  def create
    @apartment = Apartment.new(apartment_params)
    if @apartment.save
      redirect_to apartments_path
    else
      render :new
      alert("Something went wrong")
    end
  end

  private

  def apartment_params
    params.require(:apartment).permit(:title, :address, :address_url, :price_per_cleaning, :sqm, :number_of_rooms)
  end

end
