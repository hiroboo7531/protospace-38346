class CommentsController < ApplicationController
  def create
    # @comment = Comment.create(comment_params)
    # redirect_to root_path
    # ＠prototypeのインスタンス変数作って、newのアクティブメソッドでインスタンス作成。
    # カッコの中はストロングパラメータ用の引数、createメソッドはnewとsaveメソッドに分けられる
    @comment = Comment.new(comment_params)
    if @comment.save
      
      # テーブルのカラム名とフォームで記述したパラメーター名と！！！
      # ストロングパラメータで受け取る値の３つが一致している必要がある！！！
      redirect_to prototype_path(@comment.prototype)
      
    else
      # @prototype = @prototype.includes(:user)
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show"
      # この上3行の文言の内容がわからない
      # prototypeコントロで設定したインスタンス変数を読み込んだshowのviewファイルがコメントコントローラーで
      # createアクションをするときそこから飛ぼうとするビューにはインスタンス変数は読み取れないので
      # 『コメントコントローラーで再度インスタンス変数を設定する必要がある』
    end
   
  end
  private
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
  # permitに入るのはカラム名であって、マイグレーションファイルで設定した記述文言ではないよ！！！
  # ストロングパラメーターはアクションの範囲外に記述すること！！
end
