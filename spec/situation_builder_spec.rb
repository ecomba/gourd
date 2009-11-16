require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Building a situation" do
  shared_examples_for "situation builder" do
    it "adds a given step to a Situation" do
      @builder.add_step('step 1').add_step('step 2')
      @builder.steps.should == ['step 1', 'step 2']
    end
     it "builds a situation" do
      @builder.build.should == @situation
     end
  end

  context "building a situation" do
    before(:each) do
      @builder = SituationBuilder.new
      @situation = Situation.new([])
    end
    it_should_behave_like "situation builder"
  end

  context "building a background" do
    before(:each) do
      @builder = BackgroundBuilder.new
      @situation = Background.new([])
    end
    it_should_behave_like "situation builder"
  end

  context "building a scenario" do
    before(:each) do
      @builder = ScenarioBuilder.new
      @builder.with_name('Building an app')
      @situation = Scenario.new("Building another app", [])
    end

    it_should_behave_like "situation builder"
  end

end

