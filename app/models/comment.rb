class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :prototype

  validates :comment, presence: true
  # 中間テーブルは多対多の関係で使う。

end
