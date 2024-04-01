class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_user

  private
    def set_user
      if authenticated_user = User.find_by(id: cookies.encrypted[:user_id])
        Current.user = authenticated_user
      else
        Current.user = User.create!
        cookies.encrypted[:user_id] = Current.user.id
      end
    end
end
