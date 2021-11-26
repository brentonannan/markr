class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.string :test_id
      t.string :student_number
      t.integer :obtained_mark
      t.integer :available_marks

      t.timestamps
    end

    add_index(:results, [:test_id, :student_number], unique: true)
  end
end
