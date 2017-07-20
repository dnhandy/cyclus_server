class AddQueryTypeToQuery < ActiveRecord::Migration[5.1]
  def change
    add_reference :queries, :query_type, foreign_key: true
  end
end
