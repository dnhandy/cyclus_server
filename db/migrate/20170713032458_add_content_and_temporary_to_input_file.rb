class AddContentAndTemporaryToInputFile < ActiveRecord::Migration[5.1]
  def change
    add_column :input_files, :content, :binary
    add_column :input_files, :temporary, :boolean
    remove_column :input_files, :sha1sum
  end
end
