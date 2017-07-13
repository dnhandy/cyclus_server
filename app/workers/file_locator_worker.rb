require 'find'



class FileLocatorWorker
  include Sidekiq::Worker

  def perform(*args)
    input_files = []
    Find.find('/cycamore/input/') do |path|
      if path =~ /.*\.xml$/
        input_file = InputFile.where(path: path).first || InputFile.new()
        input_file.update(
          path: path,
          name: File.basename(path),
          content: File.binread(path),
          temporary: false)
      end
    end
  end
end
