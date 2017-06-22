class CyclusWorker
    include Sidekiq::Worker


    def perform(job_id)
      puts "The jobID was #{job_id}"
    end
end
