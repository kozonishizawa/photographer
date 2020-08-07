class CreateContactStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_statuses do |t|
      t.string :name
      t.text :description
      t.integer :position
      t.integer :color

      t.timestamps
    end
  end
end
