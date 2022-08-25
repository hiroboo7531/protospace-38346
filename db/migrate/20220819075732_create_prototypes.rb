class CreatePrototypes < ActiveRecord::Migration[6.0]
  def change
    create_table :prototypes do |t|
      t.string :title            ,null: false
      t.text   :catch_copy       ,null: false
      t.text   :concept          ,null: false
      t.references :user         ,null: false, foreign_key: true    
      # foreign_key:trueはcreate_tableの記述のendの後に
      # add_roreign_key :tweets,:usersと記載しても良い
         

      t.timestamps
    end
  end
end
