class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :comment  ,null: false
      t.references :user         ,null: false, foreign_key: true
      t.references :prototype         ,null: false, foreign_key: true

      t.timestamps
      # 中間テーブルは多対多の関係で使う。
      # カラム名は複数形にするな！！！
    end
  end
end
