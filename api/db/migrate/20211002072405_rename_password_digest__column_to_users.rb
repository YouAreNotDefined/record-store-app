class RenamePasswordDigestColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :password_digest_, :password_digest
  end
end
