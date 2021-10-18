class AddUserIdToRecordlibraies < ActiveRecord::Migration[6.0]
  def change
    add_reference :record_libraries, :user, optional: true, foreign_key: true
  end
end
