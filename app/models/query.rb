class Query < ApplicationRecord
  belongs_to :query_type
  has_many: :query_params
end
