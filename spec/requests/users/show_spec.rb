describe 'User API Show Endpoints' do
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:token_verified?).and_return(true)
    @user = User.create(username: 'test',
                        password: 'test',
                        email: 'test@test.com',
                        first_name: 'first',
                        last_name: 'last',
                        token: 'token')
    User.current = @user
  end

  describe 'users#show' do
    it 'returns user' do
      get "/users/#{@user.id}"

      json = JSON.parse(response.body)
      expect(json['id']).to eq(@user.id)
      expect(json['username']).to eq(@user.username)
      expect(json['first_name']).to eq(@user.first_name)
      expect(json['last_name']).to eq(@user.last_name)
      expect(json['email']).to eq(@user.email)
    end
  end
end
