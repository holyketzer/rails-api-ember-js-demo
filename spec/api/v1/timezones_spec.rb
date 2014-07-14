require 'rails_helper'

describe 'Time zones API' do
  context 'unauthorized' do
    before do
      get 'api/timezones', format: :json
    end

    it 'returns 401 status code if there is no authentication' do
      expect(response.status).to eq 401
    end
  end

  context 'authorized' do
    let!(:user) { create(:user) }

    before do
      post 'users/sign_in.json', { 'user[email]' => user.email, 'user[password]' => user.password }
      expect(response.status).to eq 201
    end

    describe 'GET index' do
      let!(:another_user) { create(:user) }

      let!(:timezones) { create_list(:timezone, 2, user: user) }
      let!(:another_timezone) { create(:timezone, user: another_user) }

      before do
        get '/api/timezones', format: :json
      end

      it 'returns 200 status code' do
        expect(response.status).to eq 200
      end

      it 'returns list of timezones' do
        expect(response.body).to have_json_size(2).at_path('timezones')
        expect(response.body).to be_json_eql(timezones.to_json).at_path('timezones').excluding('user_id')
      end
    end

    describe 'POST item' do
      let(:timezone) { build(:timezone) }

      before do
        post '/api/timezones', timezone: { name: timezone.name, city: timezone.city, gmt: timezone.gmt }, format: :json
      end

      it 'returns 201 status code' do
        expect(response.status).to eq 201
      end

      it 'returns created timezone' do
        expect(response.body).to be_json_eql(timezone.to_json(root: true)).excluding('user_id')
      end
    end

    describe 'PUT item' do
      let!(:timezone) { create(:timezone, user: user) }
      let!(:new_timezone) { build(:timezone) }

      before do
        put "/api/timezones/#{timezone.id}", timezone: { name: new_timezone.name, city: new_timezone.city, gmt: new_timezone.gmt }, format: :json
      end

      it 'returns 204 status code' do
        expect(response.status).to eq 204
      end

      it 'updates record' do
        get "/api/timezones/#{timezone.id}"

        expect(response.status).to eq 200
        expect(response.body).to be_json_eql(new_timezone.to_json(root: true)).excluding('user_id')
      end
    end

    describe 'DELETE item' do
      let!(:timezone) { create(:timezone, user: user) }

      before do
        delete "/api/timezones/#{timezone.id}", format: :json
      end

      it 'returns 204 status code' do
        expect(response.status).to eq 204
      end

      it 'deletes record' do
        get "/api/timezones/#{timezone.id}"

        expect(response.status).to eq 404
      end
    end
  end
end