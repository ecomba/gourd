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
  
  context "equality" do
    it 'two situations with the same steps are equal' do
      array =  ["a", "b", "c"]
      Situation.new(array).should == Situation.new(array)
      Situation.new(array).eql?(Situation.new(array)).should == true 
    end
    
    it 'two situations with different steps are not equal' do
      Situation.new(["a", "b"]).eql?(Situation.new(["a", "b", "c"])).should == false 
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

  context 'equality' do
    it 'is equal if two scenarios have the same members' do
      Scenario.new("scenario", []).eql?(Scenario.new("scenario", [])).should be_true
      Scenario.new("scenario", []).should == Scenario.new("scenario", [])
    end

    it 'is not equal if two scenarios have different names' do
      Scenario.new("scen", []).eql?(Scenario.new("scenario", [])).should be_false
    end
  end
end
