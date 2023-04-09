class Accounts::GetAccountData
  include Callable

  VARIANTS = {
    slide: "600x600!",
    match: "400x400!",
  }.freeze

  def initialize(accounts:, variant:)
    @accounts = accounts
    @variant = variant
  end

  def call
    accounts.map do |account|
      {
        id: account.id,
        email: account.email,
        username: account&.username,
        firstName: account&.first_name,
        lastName: account&.last_name,
        photo: avatar_path(account: account),
        age: account.age,
      }
    end
  end

  private

  attr_reader :accounts, :variant

  def avatar_path(account:)
    if account&.avatar&.blob.nil?
      'http://localhost:3000/default.png'
    else
      resized_image = MiniMagick::Image.read(account.avatar.download)
      resized_image.resize(VARIANTS[variant])

      account.avatar.attach(
        io: File.open(resized_image.path),
        filename: account.avatar.filename,
        content_type: account.avatar.content_type)

      Rails.application.routes.url_helpers.rails_blob_url(account.avatar.blob, Rails.application.config.action_mailer.default_url_options)
    end
  end
end