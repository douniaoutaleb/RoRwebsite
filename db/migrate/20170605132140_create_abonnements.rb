class CreateAbonnements < ActiveRecord::Migration
  def change
    create_table :abonnements do |t|
      t.integer :id_user
      t.integer :id_cours

      t.timestamps null: false
    end
  end
end
