require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Building a situation" do
  context "adding a step" do
    it "adds a given step to a Situation" do
      builder = SituationBuilder.new
      builder.add_step('step 1').add_step('step 2')
      builder.steps.should == ['step 1', 'step 2']
    end
     it "builds a situation" do
      builder = SituationBuilder.new
      builder.build.should == Situation.new([])
     end
  end
end
