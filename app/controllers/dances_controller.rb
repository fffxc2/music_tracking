class DancesController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    @dances = Dance.all
  end

  def new
    @dance = Dance.new
    @dance.author_id = current_user.id
  end
  
  def create
    @dance = Dance.new(dance_params)

    if @dance.valid?
      @dance.save
      redirect_to '/dances', notice: 'Dance was successfully added.'
    else
      render :new
    end
  end

  def show
    @dance = Dance.find(params[:id])
  end

  def dance_params
    params.require(:dance).permit(:name)
  end
end
