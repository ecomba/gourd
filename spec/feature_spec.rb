require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Feature" do

  context "structure" do

    before (:each) do
      @name = "Test Feature"
      @story = "In order to describe business value, as a customer, I want to define stories"
      @feature = Feature.new(@name, @story)
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
  end
end
