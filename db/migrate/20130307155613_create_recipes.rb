class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.timestamps
    end

    create_table :steps do |t|
      t.string :raw_text
      t.integer :sequence
      t.references :recipe
      t.timestamps
    end
    add_index :steps, :recipe_id

    create_table :ingredients do |t|
      t.string :raw_text
      t.references :recipe
      t.timestamps
    end
    add_index :ingredients, :recipe_id

    create_table :tags do |t|
      t.string :name
      t.references :user
      t.timestamps
    end
    add_index :tags, :user_id

    create_table :recipes_tags, :id => false do |t|
      t.integer :recipe_id
      t.integer :tag_id
    end
    add_index :recipes_tags, [:recipe_id, :tag_id]
  end
end
