class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # usersコントローラーのshowアクションにインスタンス変数@userを定義した。
    # 且つ、Pathパラメータで送信されるID値で、Userモデルの特定のオブジェクトを取得するように記述し、それを@userに代入した

    # text_fieldの後に記載されたキーでparamsに格納されています。
    # フォームで入力された情報の値は、params[:キー名]として取り出すことができます。
    # createアクションの時、newとsaveアクションにも分けられるが
    # モデル名.create(カラム名:paramsとして送られてきたデータ○例params[:キー])
    # でモデル名sテーブルのカラム名の場所へ値を保存する事ができるぞ

    # Couldn't find User with 'id'=1
    # こんなエラーが出たぞ？なんで？
    # user_path(@prototype)この書き方をuser_path(@prototype.user)にしないと
    # 画像にかかるユーザーのアソシエーションを発動するよってこと。
    # @prototypeだけだとこの画像のIDとリンクになってるユーザーのID違うじゃんって怒られる
  end
end
