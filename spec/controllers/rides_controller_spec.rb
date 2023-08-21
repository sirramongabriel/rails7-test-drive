require "rails_helper" 

RSpec.describe Api::V1::RidesController do
  describe "index" do
    it "test rides" do
      sample_response = {
        "id"=>76, 
        "driver_id"=>1, 
        "distance_in_miles"=>"965", 
        "duration_in_minutes"=>"140", 
        "commute_distance_in_miles"=>"7.6", 
        "commute_duration_in_minutes"=>"13", 
        "earnings"=>1441, 
        "score"=>10.062091503267974, 
        "created_at"=>"2023-08-21T18:07:51.002Z", 
        "updated_at"=>"2023-08-21T18:09:07.945Z"
      }
      get :index, format: "json"
      body = ActiveSupport::JSON.decode(response.body)

      expect(body['body'].first).to eq sample_response
      expect(response.status).to eq 200
    end
  end
end
