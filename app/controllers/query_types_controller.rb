class QueryTypesController < ApplicationController
  before_action :set_query_type, only: [:show, :update, :destroy]

  # GET /query_types
  def index
    @query_types = QueryType.all

    render json: @query_types
  end

  # GET /query_types/1
  def show
    render json: @query_type
  end

  # POST /query_types
  def create
    @query_type = QueryType.new(query_type_params)

    if @query_type.save
      render json: @query_type, status: :created, location: @query_type
    else
      render json: @query_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /query_types/1
  def update
    if @query_type.update(query_type_params)
      render json: @query_type
    else
      render json: @query_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /query_types/1
  def destroy
    @query_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query_type
      @query_type = QueryType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def query_type_params
      params.require(:query_type).permit(:name)
    end
end
