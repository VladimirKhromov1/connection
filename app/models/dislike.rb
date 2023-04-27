class Dislike < ApplicationRecord
  validates_uniqueness_of :disliked_account_id, scope: :account_id
end
