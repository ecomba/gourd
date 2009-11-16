require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'rack/test'

describe "Gourd::App" do
  include Rack::Test::Methods
  def app
    @app = Rack::Builder.new { run Gourd::App } 
  end
  context 'new feature' do
    it "creates a new feature when posted" do
      post '/features/', :feature => {:name => 'myname', :story => 'mystory', :background => {:steps => ['stepa', 'stepb']}, :scenarios => [{:name => 'smyname', :steps => ['sstepa', 'sstepb']}]}
      last_response.should be_ok
      last_response.content_type.should == 'application/json'
      last_response.body.should include('{saved: "ok", feature: {location: "some"}}')
    end
  end
end
