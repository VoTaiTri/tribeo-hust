class CreateSubjectUsers < ActiveRecord::Migration
  def change
    create_table :subject_users do |t|
      t.references :user, index: true
      t.references :subject, index: true

      t.timestamps null: false
    end
    add_foreign_key :subject_users, :users
    add_foreign_key :subject_users, :subjects
  end
end