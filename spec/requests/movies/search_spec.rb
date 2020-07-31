describe 'Movie API Search Endpoint' do
  it 'returns four lists of movies' do
    params = {
      title: 'Batman'
    }

    get '/search', params: params

    expect(response.status).to eq(200)

    results = JSON.parse(response.body)
    expect(results.count).to eq(20)
  end
end
