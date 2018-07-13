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
        expect(User.all).to include(User.last)
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
      post :create, params: { user: { username: 'cba', password:'abccba', email:'cba.com' } }
      expect(session[:session_token]).to eq(User.last.session_token)
    end

    it 'redirects the user to all user page' do
      post :create, params: { user: { username: 'cba', password:'abccba', email:'cba.com' } }
      expect(response).to redirect_to(user_url(User.last))
    end


  end

  describe 'GET #edit' do
    it 'renders the edit user page' do
      # patch :edit, params: { user: { username: 'cba', password:'abccba', email:'cba.com' } }
      expect(response).to render_template('edit')
    end
  end

  describe 'PATCH #update' do
    it 'update the user information'do

    user = User.create(username: 'abc', password:'abccba', email:'abc.com')
    patch :update, params: { user: { username: 'cba', password:'abccba', email:'cba.com' } }
    expect(user.username).to eq('cba')
    expect(user.email).to eq('cba.com')
    end

    it 'redirects to the user show page'
  end

  describe 'DELETE #destroy' do
    it 'removes the user from the DB'
    it 'redirects to the all users page'
  end

end
