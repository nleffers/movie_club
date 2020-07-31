describe 'User API Get Movies Endpoint' do
  describe 'users#get_movies' do
    it 'returns list of movies the user has rated' do
      allow_any_instance_of(ApplicationController).to receive(:token_verified?).and_return(true)
      user = User.create(username: 'test',
                         password: 'test',
                         email: 'test@test.com',
                         first_name: 'first',
                         last_name: 'last',
                         token: 'token')
      User.current = user

      UserMovie.create(imdb_id: 'tt0137523', user_id: user.id, rating: 10)

      get "/users/#{user.id}/movies"

      json = JSON.parse(response.body)
      expect(json.count).to eq(1)
      movie = json.first
      expect(movie['user_rating']).to eq(10)
      expect(movie['title']).to eq('Fight Club')
    end
  end
end
