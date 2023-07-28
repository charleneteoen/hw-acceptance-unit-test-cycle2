# spec/controllers/movies_controller_spec.rb
require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe "POST #create" do
    it "creates a new movie" do
      movie_params = { title: "New Movie", rating: "PG", release_date: Date.today }
      expect {
        post :create, params: { movie: movie_params }
      }.to change(Movie, :count).by(1)

      expect(flash[:notice]).to eq("#{movie_params[:title]} was successfully created.")
      expect(response).to redirect_to(movies_path)
    end
  end

  describe "GET #find_movies_with_same_director" do
    let!(:movie) { FactoryBot.create(:movie, director: "Director Name") }
    let!(:another_movie) { FactoryBot.create(:movie, director: "Director Name") }

    it "redirects to the first movie with the same director" do
      get :find_movies_with_same_director, params: { id: movie.id }
      expect(response).to redirect_to(edit_movie_path(another_movie))
    end

    it "redirects to root_path if the movie has no director" do
      movie.update(director: nil)
      get :find_movies_with_same_director, params: { id: movie.id }
      expect(response).to redirect_to(root_path)
    end

    it "redirects to root_path if no other movies found with the same director" do
      movie.update(director: "Director Name")
      get :find_movies_with_same_director, params: { id: movie.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE #destroy" do
    let!(:movie) { FactoryBot.create(:movie) }

    it "destroys the movie" do
      expect {
        delete :destroy, params: { id: movie.id }
      }.to change(Movie, :count).by(-1)

      expect(flash[:notice]).to eq("Movie '#{movie.title}' deleted.")
      expect(response).to redirect_to(movies_path)
    end
  end
end
