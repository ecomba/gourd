class Feature
  attr_reader :name, :story, :background, :scenarios

  def initialize(name, options = {})
    @name, @story, @background, @scenarios = name, options[:story], options[:background], options[:scenarios] || []
  end

  def eql?(other)
    self.name.eql?(other.name) && self.story.eql?(other.story) && self.background.eql?(other.background) &&
      self.scenarios.eql?(other.scenarios)
  end
  alias :== :eql?
end

class FeatureFactory
  attr_reader :feature_name, :scenarios, :story

  def initialize(background_builder, scenario_builder)
    @background_builder= background_builder
    @scenario_builder= scenario_builder
    @scenarios= []
  end

  def new_feature(name)
    @feature_name= name
    self 
  end

  def with_story(story)
    @story = story
    self
  end

  def background_with_steps(&proc)
    proc.call(@background_builder)
    self
  end

  def background
    @background_builder
  end

  def add_scenario_with_steps(name, &proc)
    @scenarios<< @scenario_builder.new_scenario(name, &proc)
    self
  end

  def build
    Feature.new(feature_name, :scenarios => scenarios.map {|s| s.build}, :background => background.build, :story => story)
  end

end
