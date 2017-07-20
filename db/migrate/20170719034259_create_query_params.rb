class CreateQueryParams < ActiveRecord::Migration[5.1]
  def change
    create_table :query_params do |t|
      t.string :key
      t.string :value
      t.references :query, foreign_key: true

      t.timestamps
    end
  end
end
