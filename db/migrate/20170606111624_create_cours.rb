class CreateCours < ActiveRecord::Migration
  def change
    create_table :cours do |t|
      t.string :nom
      t.string :institution
      t.string :theme
      t.string :langue
      t.integer :professeur
      t.string :description

      t.timestamps null: false
    end
  end
end
