class Prototype < ApplicationRecord
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  # dependent: :destroyを追加することで、「親モデルを削除する際に、その親モデルに紐づく「子モデル」も一緒に削除できる」ようになります。
  # 今回の場合prototypeを消したら以下のコメントも消えるっていう設定をしたいのでこんな感じ

  has_one_attached :image

  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true
  # active storageのテーブルとprototypeテーブルのアソシエーションを定義
  # 各レコードとファイルを１対１で紐付けるメソッド。prototypeのモデルを経由する各レコードは１つファイルを添付できる
  # :ファイル名。 この記述でモデル.ファイル名で添付されたファイルにアクセルできるようになる。
  # このファイル名はモデルが紐づいたフォームから送られるparamのキーにもなる（この時カラムの追加はいらん
  # 次はコントローラーにimageという名前でアクセスできるように画像ファイルの保存を許可しにいく（ストロングパラメーター

  # validates :
  # def was_attached?
  #   self.image.was_attached?
  # end
  # was_attached?メソッドの以下の文で画像があればtrueなければfalseで画像がなければテキスト必要画像があればテキスト不要

end
