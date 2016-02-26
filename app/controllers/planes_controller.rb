class PlanesController < ApplicationController
  before_action :set_plane, only: [:show, :update, :destroy]

  # GET /planes
  # GET /planes.json
  def index
    @planes = Plane.all
    render json: @planes
  end

  # GET /planes/1
  # GET /planes/1.json
  def show
    render json: @plane
  end

  # POST /planes
  # POST /planes.json
  def create
    @plane = Plane.new(plane_params)
    if @plane.save
      render json: @plane, status: :created, location: @plane
    else
      render json: @plane.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /planes/1
  # PATCH/PUT /planes/1.json
  def update
    @plane = Plane.find(params[:id])

    if @plane.update(plane_params)
      head :no_content
    else
      render json: @plane.errors, status: :unprocessable_entity
    end
  end

  # DELETE /planes/1
  # DELETE /planes/1.json
  def destroy
    @plane.destroy

    head :no_content
  end

  private

    def set_plane
      @plane = Plane.find(params[:id])
    end

    def plane_params
      params.require(:plane).permit(:name, :category, :specifications, :image)
    end
end