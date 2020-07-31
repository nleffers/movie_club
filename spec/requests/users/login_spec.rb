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

      it 'returns successful json with existing token if User already has token' do
        @user.update(token: JsonWebToken.encode({ user_id: @user.id }, Time.now.to_i + 5))
        token = @user.token
        params = {
          login: {
            username: @user.username,
            password: @user.username
          }
        }

        post '/users/login', params: params
        json = JSON.parse(response.body)
        expect(response.code).to eq('200')
        expect(json['token']).to eq(token)
        expect(json['id']).to be(@user.id)
        expect(json['username']).to eq(@user.username)
      end

      it 'rescue JWT::ExpiredSignature, sets new token' do
        @user.update(token: JsonWebToken.encode({ user_id: @user.id }, Time.now.to_i - 5))
        token = @user.token
        params = {
          login: {
            username: @user.username,
            password: @user.username
          }
        }

        post '/users/login', params: params
        json = JSON.parse(response.body)
        expect(response.code).to eq('200')
        expect(json['token']).to_not eq(token)
        expect(json['id']).to be(@user.id)
        expect(json['username']).to eq(@user.username)
      end

      it 'rescue JWT::DecodeError, returns token' do
        @user.update(token: 'token')
        params = {
          login: {
            username: @user.username,
            password: @user.username
          }
        }

        post '/users/login', params: params
        expect(response.code).to eq('401')
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
