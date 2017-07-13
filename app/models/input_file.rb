class InputFile < ApplicationRecord
  has_many :jobs

  def size
    self.content.size
  end

  def sha1
    Digest::SHA1.hexdigest(self.content)
  end

  def as_json(options = {})
    super (options.reverse_merge(
      methods: [:size, :sha1],
      except: [:content]))
  end
end
