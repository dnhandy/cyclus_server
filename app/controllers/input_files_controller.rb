require 'data_uri'

class InputFilesController < ApplicationController
  before_action :set_input_file, only: [:show, :download, :update, :destroy]

  # GET /input_files
  def index
    @input_files = InputFile.all
    render json: @input_files
  end

  # GET /input_files/1
  def show
    render json: @input_file
  end

  # GET /input_files/1/download
  def download
    send_data @input_file.content, filename: @input_file.name, type: "application/octet-stream"
  end

  # POST /input_files
  def create
    @input_file = InputFile.new(input_file_params)

    if (@input_file.content)
      uri = URI::Data.new(@input_file.content)
      @input_file.content = uri.data
    end

    if @input_file.save
      render json: @input_file, status: :created, location: @input_file
    else
      render json: @input_file.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /input_files/1
  def update
    if @input_file.update(input_file_params)
      if (@input_file.content)
        uri = URI::Data.new(@input_file.content)
        @input_file.content = uri.data
      end

      if @input_file.save
        render json: @input_file
      end
    else
      render json: @input_file.errors, status: :unprocessable_entity
    end
  end

  # DELETE /input_files/1
  def destroy
    @input_file.destroy
  end


  #POST /input_files/refresh
  def refresh
    FileLocatorWorker.perform_async()
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_input_file
      @input_file = InputFile.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def input_file_params

      params.require(:input_file).permit(:name, :temporary, :content)
    end
end
