class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.string :title
      t.string :year
      t.references :artist, optional: true, foreign_key: true
      t.references :user, optional: true, foreign_key: true

      t.timestamps
    end
  end
end
