class CreateTestResources < ActiveRecord::Migration
  def self.up
    create_table :test_resources do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :test_resources
  end
end
