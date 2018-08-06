class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.belongs_to :movie
      t.belongs_to :user
      t.string :content

      t.timestamps
    end
  end
end
