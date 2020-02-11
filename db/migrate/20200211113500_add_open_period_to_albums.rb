class AddOpenPeriodToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :open_period, :integer, default: 0, null: false
  end
end
