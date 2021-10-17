class CreateRecordLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :record_libraries do |t|
      t.references :record, null: false, foreign_key: true
      t.references :library, null: false, foreign_key: true

      t.timestamps
    end
  end
end
