describe 'User Logout', type: :request do
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

  describe 'user#logout' do
    context 'when the user_id exists' do
      it 'deletes the token and returns a 200' do
        post "/users/#{User.current.id}/logout"

        expect(response.status).to eq(200)
        expect(@user.token).to eq(nil)
        expect(User.current).to eq(nil)
      end
    end

    context 'when the user_id does not exist' do
      it 'returns a 403' do
        post "/users/#{User.current.id + 1}/logout"

        expect(response.status).to eq(403)
        expect(@user.token).to eq('token')
        expect(User.current).to eq(@user)
      end
    end
  end
end
