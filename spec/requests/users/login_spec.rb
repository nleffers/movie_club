describe 'User Login', type: :request do
  before(:each) do
    @user = create(:user)
  end

  describe 'user#login' do
    context 'when u/p is correct' do
      it 'returns successful json' do
        params = {
          login: {
            username: @user.username,
            password: @user.username
          }
        }

        post '/users/login', params: params
        json = JSON.parse(response.body)
        expect(response.code).to eq('200')
        expect(json['token'].class).to be(String)
        expect(json['id']).to be(@user.id)
        expect(json['username']).to eq(@user.username)
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
