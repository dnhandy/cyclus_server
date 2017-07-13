class AddFileIdToJob < ActiveRecord::Migration[5.1]
  def change
    add_reference :jobs, :input_file, index: true
    remove_column :jobs, :input_file_name
  end
end
