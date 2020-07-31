describe 'User Login', type: :request do
  before(:each) do
    @user = User.create(username: 'test', password: 'test', email: 'test@test.com', first_name: 'Test', last_name: 'Test')
  end

  describe 'user#login' do
    context 'when u/p is correct' do
      it 'returns successful json' do
        params = {
          login: {
            username: 'test',
            password: 'test'
          }
        }

        post '/users/login', params: params
        json = JSON.parse(response.body)
        expect(response.code).to eq('200')
        expect(json['token'].class).to be(String)
        expect(json['id']).to be(@user.id)
        expect(json['username']).to eq('test')
      end
    end

    context 'when u/p are wrong' do
      it 'returns error message' do
        params = {
          login: {
            username: 'wrong_user',
            password: 'wrong_password'
          }
        }

        post '/users/login', params: params
        json = JSON.parse(response.body)

        expect(response.code).to eq('401')
        expect(json['message']).to eq('Login Rejected')
      end
    end
  end
end
