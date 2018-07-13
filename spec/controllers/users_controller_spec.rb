require 'rails_helper'
RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    it 'renders the sign up page template' do
      get :new
      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end

  end
  describe 'POST #create' do
    context 'with valid params' do
      it 'signs up the user' do
        post :create, params: { user: { username: 'abc', password: 'abccba', email: 'abc.com'}}
        expect(response).to redirect_to(user_url(User.last))
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid params' do
      it 'redirect the user to the sign up page template' do
        post :create, params: { user: { username: ''} }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
        expect(response).to have_http_status(422)
      end
    end

    it 'logs the user in' do
      post :create, params: { user: { username: ''} }
      user = User.new(username: 'abc', password:'abccba', email:'abc.com')
      expect(User).to receive(:log_in).with(user)
      User.log_in(user)
    end

    it 'redirects the user to all user page'


  end

  describe 'GET #edit' do
    it 'renders the edit user page'
  end

  describe 'PATCH #update' do
    it 'update the user information'
    it 'redirects to the user show page'
  end

  describe 'DELETE #destroy' do
    it 'removes the user from the DB'
    it 'redirects to the all users page'
  end

end
