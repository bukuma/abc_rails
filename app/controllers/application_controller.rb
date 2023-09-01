class ApplicationController < ActionController::Base
  # この行を追加
  before_action :authenticate_user!
end
