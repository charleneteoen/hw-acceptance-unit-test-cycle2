class AddDirectorToMovies < ActiveRecord::Migration[version_number]
  def change
    add_column :movies, :director, :string
  end
end