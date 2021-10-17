class CreateLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :libraries do |t|
      t.string :name
      t.text :content
      t.references :user, optional: true, foreign_key: true

      t.timestamps
    end
  end
end
