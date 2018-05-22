class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nom
      t.string :prenom
      t.string :etablissement
      t.string :identifiant
      t.string :email
      t.string :date
      t.string :user_type

      t.timestamps null: false
    end
  end
end
