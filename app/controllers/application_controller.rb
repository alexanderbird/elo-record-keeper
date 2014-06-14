class ApplicationController < ActionController::Base
  before_action :set_config_hash
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def redirect_to_games
    redirect_to games_url
  end
  
  def not_authorized
  end
  
  private
  def set_config_hash
    @config = MTGRecordKeeper::Application.config.customization
    @config ||= HashWithIndifferentAccess.new
  rescue
    @config ||= HashWithIndifferentAccess.new
  end

  def default_url_options
    {use_api: params[:use_api]}
  end
end
