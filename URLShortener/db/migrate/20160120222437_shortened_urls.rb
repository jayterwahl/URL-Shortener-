
class ShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.timestamps
      t.string :short_url, null: false, uniqueness: true
      t.string :long_url, null: false, uniqueness: true
      t.integer :submitter_id, null: false, uniqueness: true
    end

    add_index :shortened_urls, :submitter_id
    add_index :shortened_urls, :short_url
  end
end
