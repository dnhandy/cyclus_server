class JobsController < ApplicationController
  before_action :set_job, only: [:show, :output_file, :update, :destroy]

  # GET /jobs
  def index
    @jobs = Job.all
    render json: @jobs
  end

  # GET /jobs/1
  def show
    render json: @job
  end

  def output_file
    send_data @job.output_file, filename: "#{@job.id}.sqllite", type: "application/octet-stream"
  end

  # POST /jobs
  def create
    @job = Job.new(job_params)

    if @job.save
      CyclusWorker.perform_async(@job.id)
      render json: @job, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
      render json: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_params
      params.require(:job).permit(:input_file_id, :output_file)
    end
end
