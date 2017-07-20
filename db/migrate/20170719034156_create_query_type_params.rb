class CreateQueryTypeParams < ActiveRecord::Migration[5.1]
  def change
    create_table :query_type_params do |t|
      t.string :key
      t.references :query_type, foreign_key: true

      t.timestamps
    end
  end
end
