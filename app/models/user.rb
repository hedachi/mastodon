# frozen_string_literal: true

class User < ApplicationRecord
  include Settings::Extend

  devise :registerable, :recoverable,
         :rememberable, :trackable, :validatable,
         :two_factor_authenticatable, :two_factor_backupable,
         :omniauthable,
         otp_secret_encryption_key: ENV['OTP_SECRET'],
         otp_number_of_backup_codes: 10

  belongs_to :account, inverse_of: :user
  accepts_nested_attributes_for :account

  validates :account, presence: true
  validates :locale, inclusion: I18n.available_locales.map(&:to_s), unless: 'locale.nil?'
  validates :email, email: true

  scope :prolific,  -> { joins('inner join statuses on statuses.account_id = users.account_id').select('users.*, count(statuses.id) as statuses_count').group('users.id').order('statuses_count desc') }
  scope :recent,    -> { order('id desc') }
  scope :admins,    -> { where(admin: true) }
  scope :confirmed, -> { where.not(confirmed_at: nil) }

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def setting_default_privacy
    settings.default_privacy || (account.locked? ? 'private' : 'public')
  end

  def setting_boost_modal
    settings.boost_modal
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@mldn.jp"
  end
end
