module Gourd
  class App < Sinatra::Base
    use_in_file_templates!

    post '/features/' do
      builder = FeatureFactory.new(BackgroundBuilder.new ScenarioBuilder.new).new_feature(params[:feature][:name]).with_story(params[:feature][:story])
      builder.add_background_with_steps { |background| params[:feature][:background][:steps].each { |s| background.add_step(s) }} if params[:feature][:background] 
      puts params[:feature].inspect
      content_type 'application/json'
      @saved = "ok"
      @url = "some"
      erb :feature_saved
    end
  end
end

__END__
 
@@ feature_saved
{saved: "<%= @saved %>", feature: {location: "<%= @url %>"}}
