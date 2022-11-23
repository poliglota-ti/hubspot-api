RSpec.describe Hubspot do
  it "has a version number" do
    expect(Hubspot::VERSION).not_to be nil
  end

  context "setter empty private key" do
    it "should raise error" do
      Hubspot::Settings.configure do |config|
        config.private_key = ""
      end
      expect {Hubspot::Client.new}.to raise_error(RuntimeError)
    end
  end


end

