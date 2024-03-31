class CreateWords < ActiveRecord::Migration[7.2]
  def change
    create_table :words do |t|
      t.string :fullform
      t.string :lemma
      t.string :inflection
      t.boolean :normed

      t.timestamps
    end
  end
end
