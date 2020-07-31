RSpec.describe 'Requests from Frontend' do
  let(:token) { 'token' }
  let(:headers) { { 'HTTP_X_AUTH_TOKEN' => token } }
  let(:bad_headers) { { 'HTTP_X_AUTH_TOKEN' => 'bad_token' } }
  before(:each) do
    User.current = User.create(username: 'test',
                               password: 'test',
                               email: 'test@test.com',
                               first_name: 'first',
                               last_name: 'last',
                               token: 'token')
  end

  context 'verify_authentication_token' do
    it 'does not render 401 if token is verified' do
      get "/users/#{User.current.id}/movies", headers: headers

      expect(response.status).to eq(200)
    end

    it 'renders 401 if token is not verified' do
      get "/users/#{User.current.id}/movies", headers: bad_headers

      expect(response.status).to eq(401)
    end
  end
end
