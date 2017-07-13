require 'digest/sha1'

class Job < ApplicationRecord
  belongs_to :input_file

  def output_file_size
    self.output_file.size
  end

  def output_file_sha1
    Digest::SHA1.hexdigest(self.output_file)
  end

  def input
    self.input_file.as_json
  end

  def as_json(options = {})
    super (options.reverse_merge(
      methods: [:output_file_size, :output_file_sha1, :input],
      except: [:output_file, :input_file_id]))
  end
end
