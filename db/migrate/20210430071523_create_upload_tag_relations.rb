class CreateUploadTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :upload_tag_relations do |t|
      t.references :upload, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
