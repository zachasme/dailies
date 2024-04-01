class CreateGuesses < ActiveRecord::Migration[7.2]
  def change
    create_table :guesses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :word
      t.date :guessed_on

      t.timestamps
    end
  end
end
