class Statistics::GetData
  include Callable

  def initialize(current_account_id:)
    @current_account_id = current_account_id
  end

  def call
    {
      "Your likes": Like.where(liked_account_id: current_account_id).count,
       "Your dislikes": Dislike.where(disliked_account_id: current_account_id).count
    }
  end

  private

  attr_reader :current_account_id
end