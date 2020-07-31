describe 'Movie API Home Endpoints' do
  it 'returns five movies with trailer links' do
    get '/home'

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body).count).to eq(5)
  end
end
