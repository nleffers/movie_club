describe 'Movie API Index Endpoint' do
  it 'returns four lists of movies' do
    get '/movies'

    expect(response.status).to eq(200)

    results = JSON.parse(response.body)
    expect(results['top_rated'].count).to eq(20)
    expect(results['upcoming'].count).to eq(20)
    expect(results['popular'].count).to eq(20)
    expect(results['now_playing'].count).to eq(20)
  end
end
