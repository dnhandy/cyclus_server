class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :input_file_name
      t.binary :output_file

      t.timestamps
    end
  end
end
