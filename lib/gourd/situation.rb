class Situation
  attr :steps

  def initialize(steps)
    @steps = steps
  end

  def eql?(other)
    self.steps.eql? other.steps
  end
  alias :== :eql? 
end

class Background < Situation
end

class Scenario < Situation
  attr :name

  def initialize(name= nil, steps= [])
    @name = name
    super(steps)
  end

  def eql?(other)
    self.name == other.name && super(other)
  end
end

class SituationBuilder
  attr :steps

  def initialize
    @steps= []
  end

  def add_step(step)
    @steps<< step
    self
  end

  def build
    Situation.new(@steps)
  end
end

class BackgroundBuilder < SituationBuilder; end

class ScenarioBuilder < SituationBuilder
  def initialize
    super
  end

  def with_name(name)
    @name = name
    self
  end

  def build
    Scenario.new(@name, @steps)
  end
end
