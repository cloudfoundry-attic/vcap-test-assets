require "spec_helper"
require "rest-client"

describe "Sinatra Application" do
  let(:environment) { {} }
  before do
    start_can_i_bump({env: environment})
  end

  after do
    stop_can_i_bump
  end

  describe "GET /" do
    it "returns no by default" do
      response = make_get_request
      expect(response.body).to match /NO/
      expect(response.body).to match /No data yet/
    end

    context "when the value the set to yes" do
      before do
        make_put_request("yes?reason=idunno")
      end

      it "returns yes" do
        response = make_get_request
        expect(response.body).to match /YES/
      end

      it "prints out the reason" do
        response = make_get_request
        expect(response.body).to match /idunno/
      end
    end

    context "when the value the set to no" do
      before do
        make_put_request("no")
      end

      it "returns no" do
        response = make_get_request
        expect(response.body).to match /NO/
      end
    end

    context "when the value is not yes or no" do
      it "should fail" do
        expect {
          make_put_request("lala")
        }.to raise_error(RestClient::InternalServerError)
      end
    end

    context "when token is set in env variable" do
      let(:environment) { { "CAN_I_BUMP_TOKEN" => "app_token" } }

      context "when the specified token does not match app token" do
        it "return Unauthorized" do
          expect{
            make_put_request("yes?token=request_token")
          }.to raise_error(RestClient::Unauthorized)
        end
      end

      context "when the specified token matches app token" do
        it "returns 200" do
          response = make_put_request("yes?token=app_token")
          expect(response.code).to eq(200)
        end
      end
    end
  end
end