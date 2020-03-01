class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.string :name
      t.decimal :cost

      t.timestamps
    end
  end
end
