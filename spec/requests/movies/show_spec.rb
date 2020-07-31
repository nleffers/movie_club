describe 'Movie API Show Endpoint' do
  it 'returns details and reviews for a movie' do
    user = create(:user)
    review = Review.create(user_id: user.id, imdb_id: 'tt0137523', title: 'test', blog: 'test')

    get '/movies/550'

    expect(response.status).to eq(200)
    
    result = JSON.parse(response.body)
    expect(result['casts'].count).to be > 0
    expect(result['reviews'].count).to eq(1)
    expect(result['reviews'].first).to eq(JSON.parse(review.to_json).merge('written_by_username' => user.username))
  end
end
