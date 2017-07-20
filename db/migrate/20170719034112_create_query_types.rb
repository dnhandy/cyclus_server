class CreateQueryTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :query_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
