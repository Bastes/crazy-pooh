class CreateAchievements < ActiveRecord::Migration
  def self.up
    create_table :achievements do |t|
      t.string :section
      t.string :subsection
      t.string :title
      t.text :description
      t.string :exhibit_file_name
      t.string :exhibit_content_type
      t.integer :exhibit_file_size
      t.datetime :exhibit_updated_at
      t.integer :crop_x
      t.integer :crop_y
      t.integer :crop_w
      t.integer :crop_h

      t.timestamps
    end

    add_index :achievements, :section
    add_index :achievements, :subsection
    add_index :achievements, :created_at
  end

  def self.down
    drop_table :achievements
  end
end
