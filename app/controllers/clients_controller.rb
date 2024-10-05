class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
    @client.build_user
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to clients_path
    else
      render :new
      alert("Something went wrong")
    end
  end

  def search
    query = params[:query]
    clients = Client.where("first_name ILIKE ?", "%#{query}%")

    respond_to do |format|
      format.json { render json: clients.map { |client| { id: client.id, first_name: client.first_name, last_name: client.last_name } } }
    end

  end


  def client_params
    params.require(:client).permit(:user_attributes => [:email, :password, :first_name, :last_name])
  end

end
