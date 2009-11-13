require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Feature" do

  context "structure" do

    before (:each) do
      @name = "Test Feature"
      @story = "In order to describe business value, as a customer, I want to define stories"
      @feature = Feature.new(@name, :story => @story)
    end

    it "has a name" do
      @feature.name.should == @name 
    end

    it "has a story" do
      @feature.story.should == @story
    end

    it "the name is inmutable" do
      lambda { @feature.name= "new name" }.should raise_error
    end

    it "the story is immutable" do
      lambda { @feature.story= "new story" }.should raise_error
    end

    it "contains a background" do
      background = Background.new([])
      Feature.new(nil, :background => background).background.should == background
    end

    it "contains scenarios" do
      scenarios = [Scenario.new('scenario 1'), Scenario.new('scenario 2')]
      Feature.new(nil, :scenarios => scenarios).scenarios.should == scenarios
    end

    it "contains an empty scenario" do
      Feature.new(nil).scenarios.should == []
    end
  end
  context "equality" do
    it "is equal when all members are equal" do
      Feature.new("a feature", :scenarios => [], :background => Background.new([]), :story => "").eql?(
        Feature.new("a feature", :scenarios => [], :background => Background.new([]), :story => "")).should be_true
    end
  end
end

describe "FeatureFactory" do
  context "building feaures" do

    before(:each) do
      @background_builder = mock(:BackgroundBuilder, :null_object => true, :steps => ["my step"])
      @scenario_builder = mock(:ScenarioBuilder, :null_object => true, :steps => ["my step"]) 
      @factory= FeatureFactory.new(@background_builder, @scenario_builder)
      @factory.new_feature("My Feature")
    end

    it "creates a new factory for building a feature" do
      @factory.feature_name.should == "My Feature"
    end

    it "adds a background to the feature" do
      @factory.background_with_steps{|background| background.add_step("my step")}.background.steps.should == ["my step"]
    end

    it "adds a scenario to the feature" do
      @factory.add_scenario_with_steps("My scenario") {|scenario| scenario.add_step("my step")}.scenarios.first.steps.should == ["my step"]
    end

    it "constructs the feature and its situations" do
      @background_builder.should_receive(:build).and_return(Background.new(["BS"]))
      @scenario_builder.should_receive(:build).and_return(Scenario.new("S", ["SA"]))
      @factory.background_with_steps{|b| b.add_step("BS")}.add_scenario_with_steps("S") {|s| s.add_step("SA")}
      @factory.build.should == Feature.new("My Feature", :background => Background.new(["BS"]), 
              :scenarios => [Scenario.new("S", ["SA"])])
    end
  end
end
