class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.date :date
      t.integer :student_id
      t.boolean :attending
      t.text :reason
      t.string :files
      t.timestamps
    end
  end
end
