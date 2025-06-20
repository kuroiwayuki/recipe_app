class ApplicationController < ActionController::Base
  # サポートされているブラウザのみ機能を使えるようにしている
  allow_browser versions: :modern
  # ログイン済みユーザーのみがアクセス可能
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path
  end
end
