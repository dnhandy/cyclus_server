require 'sqlite3'

class QueriesController < ApplicationController
  before_action :set_query, only: [:show, :update, :destroy, :execute]

  # GET /queries
  def index
    @queries = Query.all

    render json: @queries
  end

  # GET /queries/1
  def show
    render json: @query
  end

  # POST /queries
  def create
    begin
      @query = Query.new(query_params)

      if @query.save
        render json: @query, status: :created, location: @query
      else
        render json: @query.errors, status: :unprocessable_entity
      end
    rescue
      puts $!
    end
  end

  # PATCH/PUT /queries/1
  def update
    if @query.update(query_params)
      render json: @query
    else
      render json: @query.errors, status: :unprocessable_entity
    end
  end

  # GET /queries/1/execute
  def execute
    result = { columns:[], rows:[]}
    begin
      jobID = params['jid']

      job = Job.find(jobID)
      if (job && job.output_file)
        tmp_file = "/tmp/#{SecureRandom.urlsafe_base64}.sqllite"

        File.open(tmp_file, 'wb') do |f|
          f.write(job.output_file)
        end

        begin
          db = SQLite3::Database.open(tmp_file)
          statement = db.prepare(@query.query_string)
          rs = statement.execute()

          result[:columns] = rs.columns
          rs.each do |row|
            result[:rows] << row
          end
        ensure
          statement.close if statement
          db.close if db
        end
      end
      render json: result
    rescue
      puts $!
      render json: { error: $!.to_string() }
    end
  end

  # DELETE /queries/1
  def destroy
    @query.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query = Query.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def query_params
      params.require(:query).permit(:name, :query_string)
    end
end
