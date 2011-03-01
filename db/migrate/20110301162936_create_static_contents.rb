class CreateStaticContents < ActiveRecord::Migration
  def self.up
    create_table :static_contents do |t|
      t.string :codename
      t.text :content
    end

    add_index :static_contents, :codename
  end

  def self.down
    drop_table :static_contents
  end
end
