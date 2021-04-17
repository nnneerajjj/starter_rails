class CreateAuthorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.string :token
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index(:authorizations, [:provider, :uid], unique: true)
  end
end
