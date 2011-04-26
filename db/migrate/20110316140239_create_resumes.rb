class CreateResumes < ActiveRecord::Migration
  def self.up
    create_table :resumes do |t|
      t.string :label
      t.string :exhibit_file_name
      t.string :exhibit_content_type
      t.integer :exhibit_file_size
      t.datetime :exhibit_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :resumes
  end
end
