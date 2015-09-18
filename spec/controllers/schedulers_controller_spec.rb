require 'rails_helper'

describe SchedulersController do
  describe 'GET index' do
    before { get :index }

    it { expect(response).to have_http_status 200 }
    it { expect(response).to render_template("index") }
  end

  describe 'POST create' , focus: true do
    let(:date_time) { Time.now.strftime("%d/%m/%y %H") }

    before { post :create, { scheduler: { date: date_time } } }

    it { expect(response).to have_http_status 302 }
    it { expect(response).to redirect_to schedulers_url }
  end
end