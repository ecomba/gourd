require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Situation" do

  context "structure" do

    it "has a step" do
      situation = Situation.new(["a step"])
      situation.steps.should == ["a step"]
    end
    
    it "has many steps" do
      steps = ["1 step", "2 step", "3 step"]
      situation = Situation.new(steps)
      situation.steps.should == steps
    end

  end
end

describe "Background" do
  it "is a situation" do
    Background.new([]).is_a?(Situation).should be_true
  end
end

describe "Scenario" do
  it "is a situation" do
    Scenario.new([]).is_a?(Situation).should be_true
  end

  context "structure" do
    it "has a name" do
      name = "my name"
      Scenario.new(name, []).name.should == name
    end

    it "has steps too" do
      steps = ["step 1", "step 2"]
      Scenario.new(nil, steps).steps.should == steps
    end
  end
end
