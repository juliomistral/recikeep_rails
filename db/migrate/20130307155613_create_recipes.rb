class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :tags

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

    create_table :recipe_tags, :id => false do |t|
      t.references :recipes, :tags
    end
    add_index :recipe_tags, [:recipes_id, :tags_id]
  end
end
