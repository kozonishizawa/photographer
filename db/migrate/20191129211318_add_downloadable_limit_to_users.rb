class AddDownloadableLimitToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :downloadable_limit, :integer
  end
end
