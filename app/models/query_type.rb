class QueryType < ApplicationRecord
  has_many :queries
  has_many :query_type_params
end
