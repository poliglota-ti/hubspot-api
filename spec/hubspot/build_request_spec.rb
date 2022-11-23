RSpec.describe Hubspot::BuildRequest do
  before do
    Hubspot::Settings.configure do |config|
      config.private_key = Dotenv.load["PRIVATE_KEY"]
    end
  end

  describe "request to search user" do
    context "when make to request with out params or error format params" do
      let(:error_params){
        {
          asdasdasd: [{
            "error":[{
              "value": "error@gmail.com",
              "propertyName": "email",
              "operator": "EQ"}]
          }]
        }
      }

      let(:good_params){
        {
          filterGroups: [{
            "filters":[{
              "value": "error@gmail.com",
              "propertyName": "email",
              "operator": "EQ"}]
          }]
        }
      }
  
      it 'should be error request whit out params' do
        expect{Hubspot::BuildRequest.search_contact()}.to raise_error(RuntimeError)
      end

      it 'should be error because return all contacts with bad params' do
        not_found = Hubspot::BuildRequest.search_contact(error_params)["total"] > 1
        expect(not_found).to eq(true)
      end

      it 'should be error because return all contacts whit good params but not exist email' do
        not_found = Hubspot::BuildRequest.search_contact(good_params)["total"] == 0
        expect(not_found).to eq(true)
      end

    end
    context "when make to request and find the user" do
      let(:params){
        {
          filterGroups: [{
            "filters":[{
              "value": "nore@test.cl",
              "propertyName": "email",
              "operator": "EQ"}]
          }]
        }
      }

      it "should find the one user" do
        found = Hubspot::BuildRequest.search_contact(params)["total"] == 1
        expect(found).to eq(true)
      end

      it 'should find the one user get the email' do
        email = 'nore@test.cl'  
        find_email = Hubspot::BuildRequest.search_contact(params)["results"].first["properties"]["email"]
        expect(email).to eq(find_email)
      end

    end
  end

  describe "create user" do
    context "when send bad params" do
      let(:bad_params){
        {
          eroor:"eror",
          as: "asdasd",
          other: "asd"
        }
      }
      it 'empty params' do
        expect{Hubspot::BuildRequest.create_user()}.to raise_error(RuntimeError)
      end
      
      it 'bad params' do
        expect{Hubspot::BuildRequest.create_user(bad_params)}.to raise_error(RuntimeError)
      end
    end

    context "when send god params" do
      let(:good_params){
        {"properties": {
          "email": Faker::Internet.email,
          "firstname": Faker::Name.name,
          "lastname": Faker::Name.name,
          "phone": Faker::PhoneNumber.cell_phone_in_e164,
          "numero_de_identificacion": nil,
          "national_identity_type": "123456",
          "country": "MX"
        }}
      }

      it 'create user and return email' do
        res = Hubspot::BuildRequest.create_user(good_params)
        expect(res["properties"]["email"]).to eq(good_params[:properties][:email])
      end
    end
  end

  describe 'create and update deals' do
    context 'error create' do
      let(:bad_params){
        {
          error: "errors",
          test: "test"
        }
      }
      it 'empty params' do
        expect{Hubspot::BuildRequest.create_deal()}.to raise_error(RuntimeError)
      end

      it 'bad params' do
        expect{Hubspot::BuildRequest.create_deal(bad_params)}.to raise_error(RuntimeError)
      end
    end

    context 'success create' do
      let(:good_params){
        # Stage Cierre Automatico Ganado
        {
          "properties": {
            "amount": "1500",
            "payed_amount": "1500",
            "closedate": Time.now.to_i * 1000,
            "dealname": Faker::Name.name,
            "deal_currency_code": "CLP",
            "dealstage": 11368479,
            "pipeline": 1277517
          }
        }
      }
      it 'create deal success and get id' do
        expect(Hubspot::BuildRequest.create_deal(good_params).keys.include?("id")).to eq(true)
      end
    end

    context 'update' do
      let(:good_params){
        {
          "properties": {
            "amount": "15000000",
            "payed_amount": "1500000",
            "closedate": Time.now.to_i * 1000,
            "dealname": Faker::Name.name,
            "deal_currency_code": "CLP",
            "dealstage": 4417460,
            "pipeline": 1277517
          }
        }
      }
      let(:new_deal){Hubspot::BuildRequest.create_deal(good_params)}
      let(:new_stage_params){
        # Stage Cierre Automatico Ganado
        {
          "properties": {
            "dealstage": 11368479,
          }
        }
      }
      it 'update stage' do
        id = new_deal["id"]
        expect(Hubspot::BuildRequest.update_deal(new_stage_params, id)["properties"]["dealstage"]).to eq(new_stage_params[:properties][:dealstage].to_s)
      end
      
    end
  end

  describe 'association contact with deal' do
    let(:params_contact){
        {"properties": {
          "email": Faker::Internet.email,
          "firstname": Faker::Name.name,
          "lastname": Faker::Name.name,
          "phone": Faker::PhoneNumber.cell_phone_in_e164,
          "numero_de_identificacion": nil,
          "national_identity_type": "123456",
          "country": "MX"
        }}
      }

    let(:params_deal){
      # Stage Cierre Automatico Ganado
      {
        "properties": {
          "amount": "1500",
          "payed_amount": "1500",
          "closedate": Time.now.to_i * 1000,
          "dealname": Faker::Name.name,
          "deal_currency_code": "CLP",
          "dealstage": 11368479,
          "pipeline": 1277517
        }
      }
    }
    let(:send_params){
      "contactId": params_contact["id"],
      "toObjectType": "Deal",
      "toObjectId": params_deal["id"]

    }
    let(:new_deal){Hubspot::BuildRequest.create_deal(params_deal)}
    let(:contact){Hubspot::BuildRequest.create_user(params_contact)}
    
    it '' do
      
    end
  end

end
