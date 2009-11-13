class Situation
  attr :steps

  def initialize(steps)
    @steps = steps
  end
end

class Background < Situation
end

class Scenario < Situation
  attr :name

  def initialize(name= nil, steps= [])
    @name = name
    super(steps)
  end
end

