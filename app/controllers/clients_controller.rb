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
    clients = Client.joins(:user)
                    .where('users.first_name ILIKE :query OR users.last_name ILIKE :query', query: "#{query}%")

    respond_to do |format|
      format.json do
        render json: clients.map { |client| {
          id: client.id,
          first_name: client.user.first_name,
          last_name: client.user.last_name }
        }
      end
    end

  end


  def client_params
    params.require(:client).permit(:user_attributes => [:email, :password, :first_name, :last_name])
  end

end
