class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  private
  def set_locale
    # I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = :de
  end
end
