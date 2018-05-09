class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  private
  def set_locale
    # I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = :de
  end

  def authenticate_admin
    unless (current_user && current_user.admin?)
      redirect_to root_path, alert: t(:not_authorized)
    end
  end
end
