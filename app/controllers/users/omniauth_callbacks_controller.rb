class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    callback_from :facebook
  end

  def twitter
    callback_from :twitter
  end

  private

  def callback_from(provider)
    provider = provider.to_s

    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
    else
      #cookieが大きすぎてエラーになるので下記のように修正
      #ActionDispatch::Cookies::CookieOverflow エラー | EasyRamble http://easyramble.com/cookie-overflow-on-rails.html
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      @user.account = Account.new
      @user.account.username = request.env["omniauth.auth"].info["nickname"]
      @user.save!
    end

    sign_in @user
    redirect_to '/auth/sign_in'
  end
end
