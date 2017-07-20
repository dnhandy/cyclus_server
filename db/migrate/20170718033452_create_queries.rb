class CreateQueries < ActiveRecord::Migration[5.1]
  def change
    create_table :queries do |t|
      t.string :name
      t.string :query_string

      t.timestamps
    end
  end
end
