class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :tc
      t.integer :lt, default: 0
      t.integer :bt, default: 0
      t.string :subjectID
      t.string :species, default: "normal"

      t.timestamps null: false
    end

    add_index :subjects, :subjectID
  end
end
