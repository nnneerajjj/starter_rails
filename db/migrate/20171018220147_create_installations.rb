# frozen_string_literal: true

class CreateInstallations < ActiveRecord::Migration[5.2]
  def change
    create_table :installations do |t|
      t.references :user, foreign_key: true
      t.string :token

      t.timestamps
    end

    add_index :installations, %i[user_id token], unique: true
  end
end
