class ApplicationController < ActionController::Base
  # before_action :authenticate_user!, only: [:show]
  # ログイン状態でページを切り替えるdeviseメソッド。処理が呼ばれたときユーザーがログインしてないければログイン画面へ
  # コンマ以下の記述が未ログインユーザーでもできること

  #後からusers用のマイグレーションファイルを作ってカラムを加えることが可能、ただemailとパスワード以外の人力で加えたカラムはコントローラーで追記が必要
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  # :devise_controller?というdeviseのヘルパーメソッド名を指定して、もしdeviseに関するコントローラーの処理であれば、
  # そのときだけconfigure_permitted_parametersメソッドを実行するように設定

  # ①before_action :move_to_index, except: [:index, :show]
                    # ただのメソッド名
  private
  def configure_permitted_parameters
    # この上のメソッド名は慣習なので本来自由
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name ,:profile ,:occupation ,:position ])
  end

  # ②def move_to_index
  #   unless user_signed_in?
  #     redirect_to action: :index
  #   end
  # end

#deviseの処理を行うコントローラーはgem内に記述されているため編集することはできない、
# permitの後にsign_upとあるが個々の処理名はそういう記載と決まっている
# :sign_in	サインイン（ログイン）の処理を行うとき
# :sign_up	サインアップ（新規登録）の処理を行うとき
# :account_update	アカウント情報更新の処理を行うとき


end