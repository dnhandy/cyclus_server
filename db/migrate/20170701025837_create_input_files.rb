class CreateInputFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :input_files do |t|
      t.string :name
      t.string :path
      t.string :sha1sum

      t.timestamps
    end
  end
end
