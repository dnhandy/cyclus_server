class CyclusWorker
    include Sidekiq::Worker

    Sidekiq.configure_server do |config|
      config.redis = {
        namespace: 'cyclus',
        url: 'redis://redis:6379/0'
      }
    end

    Sidekiq.configure_client do |config|
      config.redis = {
        namespace: 'cyclus',
        url: 'redis://redis:6379/0'
      }
    end

    def perform(job_id)
      puts "The jobID was #{job_id}"
    end
end
