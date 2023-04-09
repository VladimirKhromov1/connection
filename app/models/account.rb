class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  def matches
    liked_account_ids = Like.where(account_id: self.id).map(&:liked_account_id)
    likes_me_account_ids = Like.where(liked_account_id: self).map(&:account_id)

    matches_ids = liked_account_ids.select { |id| likes_me_account_ids.include?(id) }

    Account.where(id: matches_ids)
  end
end
