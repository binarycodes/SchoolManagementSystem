class AddImageToStudents < ActiveRecord::Migration
  def change
    add_column :students, :image, :string
    add_column :students, :image_add_remove, :date
  end
end
