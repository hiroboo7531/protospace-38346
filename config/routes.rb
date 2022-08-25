Rails.application.routes.draw do
  devise_for :users
  # rails g devise:installとrails g devise userをする過程で自動で生成される⇨rails g devise:viewsを実行
  root to: "prototypes#index"
  # ルートパスでトップページを出せるように、コントローラー用のアクション設定の後やる。to: "●"がミソっぽい
  resources :prototypes do
    resources :comments, only: :create
    # ツイートにコメント投稿しよう、ネストの考え方
    # ルーティングにネストを利用しなければ、モデルと結びついている別モデルのid情報が送れなくなります
    # ルーティングをネストさせる一番の理由は、アソシエーション先のレコードのidをparamsに追加してコントローラーに送るため
  # , only: [:index, :new, :create , :show , :edit ,:update ,:destroy]
  # No route matches [POST] "/prototypes/12"ってエラーが出た
  # /prototypes/:id にPOSTがない   という事らしい
 
  # resources :comments, only: :create
  # パスの中にどのツイートへのコメントなのかを示す情報がありません。コメントには必ずコメント先となるツイートが存在しているはずです。
  # コメントを投稿する際には、どのツイートに対するコメントなのかをパスから判断できるようにしたいので、ここではルーティングのネストという方法を使っていきます。
  # resources :親となるコントローラー do
  #   resources :子となるコントローラー


#resources :users, only: :show
# 上のusersルーティングはだめ！！！resources:prototypes doのネストの中に入っちゃってる
# do~endの外にルーティングして
#  do~endの中にユーザーコントローラーの記載をしたときprefixはprototype_user_pathとなったどういう意味か？
# プロトタイプありきになってしまう、おかしい
# コメントのcreateアクションの時はprototype_commentsとなってるよね

  end
  resources :users, only: :show
end

# resources :photos, :books, :videos
# 上の記法は以下と完全に同一です。

# resources :photos
# resources :books
# resources :videos
