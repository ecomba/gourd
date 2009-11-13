class Feature
  attr_reader :name, :story

  def initialize(name, story = nil)
    @name, @story = name, story
  end
end
