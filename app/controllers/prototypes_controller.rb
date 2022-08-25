class PrototypesController < ApplicationController

  # ログイン状態でページを切り替えるdeviseメソッド。処理が呼ばれたときユーザーがログインしてないければログイン画面へ
  # コンマ以下の記述が未ログインユーザーでもできること
  before_action :authenticate_user!, only: [:new,:create,:edit,:update,:destroy]
  # except: [:index, :show]と書いても問題ないよ
  # 全てのアクションの前に、ユーザーがログインしているかどうか確認する！
  # ただし、showアクションと、indexアクションが呼び出された場合は、除くよ。という意味
  # only: [:new,:create,:edit,:update,:destroy]
  
  
  # before_action :set_prototype, except: [:index, :new, :create] ここはonly: [:show,:edit,:update,:destroy]という記述でもいける
  # 重複しているコードを別のdef set_prototype ~ endでメソッド化して同じコードを読み込ませるようにしている
  # メソッド化してbeforeアクションで使う場合メソッド化するコードはストロングパラメータprivateの中に書くこと！！！
  

  # before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  # この文の重要なところは、これをつけないと、ログインさえしていればurlを弄って他の人の投稿も
  # 編集、更新、削除ができてしまう大問題！！！
  # exceptオプション
  # before_actionで使用できるオプションです。exceptは「除外する」という意味があります。
  # こちらの後に指定したアクションに対しては、事前処理は実行されません。
  # onlyオプション  only:の後のやつだけ読む事ができるよ

  before_action :correct_signin_user, only: [:edit , :destroy, :update]

  def index
    @prototypes = Prototype.all
    # オールを使うときは複数形のが良い
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    # ＠prototypeのインスタンス変数作って、newのアクティブメソッドでインスタンス作成。
    # カッコの中はストロングパラメータ用の引数、createメソッドはnewとsaveメソッドに分けられる
    if @prototype.save
      redirect_to root_path
      # (@prototype)
    else
      # @prototype = @prototype.includes(:user)
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
    # showアクションにインスタンス変数を定義しその投稿に紐づく全てのコメントを代入
    # includesメソッドは、引数に指定された関連モデルを1度のアクセスでまとめて取得できます。
    # includesメソッドを使用するとすべてのレコードを取得するため、allメソッドは省略可能
    # プロトタイプの特定のIDを含むインスタンス変数にかかるアソシエーション関係のコメントに紐づくユーザー情報をコメンツインスタンス変数へ 


    
  end
  def edit
    @prototype = Prototype.find(params[:id])
    # before action：で短縮可
    
  end

  def update
    @prototype = Prototype.find(params[:id])
    # prototype.update(prototype_params)
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
      
    else
      # createアクションを参考
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.id)
    # permit内に全ての保存予定のカラムを入力しないとダメ、permit内に書いてないものは入力欄は通らず
    # バリデーションで弾かれてif文のfalseに入ってると思われる
    # 定義したものはendで締めて
  end

    # params.require(:モデル名).permit(:キー名, :キー名)モデル名の取得したいキーを指定
    
    # mergeメソッド。複数のハッシュを結合させるメソッド。
    # hash1 = {neko: kuro , inu: hachi}
    # hash2 = {tori: poppo, kame: kame}
    # hash3 = hash1.merge(hash2)
    # puts hash3  出力=> {neko: kuro, inu:hachi, tori:poppo, kame:kame}

    # def set_prototype
      # @prototype = Prototype.find(params[:id])
    # end
    # ビフォーアクションで設定されたメソッド、同じ記述を重複させないためのもの

    # def contributor_confirmation  
      # 米beforeアクションで呼び出されるやつ
      # redirect_to root_path unless current_user == @prototype.user
      # ログイン中のユーザーと投稿されている画像のユーザー情報が一緒じゃないならトップページに戻せ？
    # end

    def correct_signin_user
      # このエラー分が出た。undefined method `user' for nil:NilClass Did you mean? super
      # どういう意味？
      # userってメソッドを入れるレシーバー（値を受け取る先、値が紐づいている先）なんてnil（空）ですよ
      # userってメソッドなの？  ドットの後に続くものはメソッドと捉えてよし
      # ってことはレシーバーは@prototypeか！
      # でもaction内でインスタンス変数って定義してるじゃん！
      # ストロングパラメタのこの記述はビフォーアクションだから！！！
      # アクション内で定義していてもそれを読む前にこっちを読んじゃう、なんてこった
      # これを解除する方法は２つ
      # まずビフォーアクションのここに定義してあげること
      # あとはbefore_actionでアクション内の重複している記述を先に読ませること！だから重複文はビフォーアクションのがいいのだ
      @prototype = Prototype.find(params[:id])
        redirect_to root_path unless current_user == @prototype.user
    end

 
end
# エラー文
# <%= blog.user.email %> ActionView::Template::Error (undefined method `email' for nil:NilClass)
# 一旦undefined method emailから離れましょう！このエラーで大事なのは、undefinedと言われているメソッドのレシーバです！
# レシーバとは、メソッドを実行する対象を指しています！今回の場合、emailメソッドを実行する対象はuserです！
# ドットの後に続く言葉はメソッド
