class ApplicationController < ActionController::Base
  before_action :set_locale

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def change_locale
  locale = params[:locale].to_s

  if ["pt-BR", "en"].include?(locale)
    session[:locale] = locale
    I18n.locale = locale
  end

  redirect_back(fallback_location: root_path)
end

private

def set_locale
  I18n.locale = session[:locale] || I18n.default_locale
end
end