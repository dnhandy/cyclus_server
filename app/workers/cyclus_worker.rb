class CyclusWorker
  include Sidekiq::Worker

  def get_sha1(path)
    `sha1sum #{path}`.split(" ")[0]
  end

  def perform(job_id)
    begin
      job = Job.find(job_id)

      if (job && job.input_file)
        job.update(status: 'Started')

        path = nil
        delete_path = false

        # First check to see if it's a permanent cyclus file
        if (
          job.input_file.path &&
          File.exist?(job.input_file.path) &&
          get_sha1(job.input_file.path) == job.input_file.sha1)
        then
          path = job.input_file.path
        end

        # If not, see if it's a permanent custom file that's already been
        # uploaded to this worker
        if (!path && job.input_file.contents)
          shaPath = "/tmp/#{job.input_file.sha1}.xml"

          if (File.exist?(shaPath) && get_sha1(shaPath) == job.input_file.sha1)
            path = shaPath
          end

          if (!path)
            job.update(status: 'Retrieving input file')
            File.open(shaPath, 'w') { |file| file.write(job.input_file.contents) }
            path = shaPath
            delete_path = job.input_file.temporary
          end
        end

        if (path)
          job.update(status: 'Executing cyclus')
          output_file = "/tmp/#{job_id}.sqllite"
          if system( "cyclus -o #{output_file} #{path}" )
            job.output_file = File.read(output_file);
            job.status = "Complete"
            job.save()
          else
            job.update(status: 'Error executing cyclus')
          end

          if (delete_path)
            File.delete(path)
          end
        else
          job.update(status: 'Input file not found')
        end
      end
    rescue
      
    end
  end
end
