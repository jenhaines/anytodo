class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.boolean :completed, default: false
      t.references :list, index: true

      t.timestamps null: false
    end
    add_foreign_key :items, :lists
  end
end
