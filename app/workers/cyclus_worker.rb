class CyclusWorker
    include Sidekiq::Worker


    def perform(job_id)
      job = Job.find(job_id);
      if job && job.input_file_name && File.exist?(job.input_file_name)
        output_file = "/tmp/#{job_id}.sqllite"
        if system( "cyclus -o #{output_file} #{job.input_file_name}" )
          job.output_file = File.read(output_file);
          job.save()
        end
      end;
    end
end
