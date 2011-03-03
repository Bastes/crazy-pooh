class CreateExternalLinks < ActiveRecord::Migration
  def self.up
    create_table :external_links do |t|
      t.string :section
      t.integer :rank
      t.string :label
      t.text :description
      t.text :url
      t.string :banner_file_name
      t.string :banner_content_type
      t.integer :banner_file_size
      t.datetime :banner_updated_at

      t.timestamps
    end

    add_index :external_links, :section
    add_index :external_links, :rank
  end

  def self.down
    drop_table :external_links
  end
end
