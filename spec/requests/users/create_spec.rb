describe 'User API Create endpoints' do
  context 'user create' do
    it 'creates a user successfully' do
      params = {
        user: {
          username: 'test',
          password: 'test',
          email: 'test@test.com',
          first_name: 'first',
          last_name: 'last'
        }
      }

      post '/users/', params: params
      json = JSON.parse(response.body)

      user = User.first

      expect(json['id']).to eq(user.id)
      expect(json['username']).to eq('test')
      expect(json['token']).to eq(user.token)
      expect(User.current).to eq(user)
    end
  end
end
