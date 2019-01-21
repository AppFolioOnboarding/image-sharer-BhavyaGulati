# This migration comes from acts_as_taggable_on_engine (originally 1)
if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class ActsAsTaggableOnMigration < ActiveRecord::Migration[4.2]; end
else
  class ActsAsTaggableOnMigration < ActiveRecord::Migration; end
end
ActsAsTaggableOnMigration.class_eval do
  create_table :taggings do |t|
    t.references :tag
    t.references :taggable, polymorphic: true
    t.references :tagger, polymorphic: true
    t.string :context, limit: 128
    t.datetime :created_at
    t.timestamps
  end

  def self.up
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end
    add_index :taggings, :tag_id
    add_index :taggings, %i[taggable_id taggable_type context]
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
