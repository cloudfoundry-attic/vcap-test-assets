require "deciders/pingdom"
require "deciders/jenkins"

class FinalDecider
  def initialize(deciders)
    @deciders = deciders
  end

  def reasons
    reasons = []
    @deciders.each do |decider|
      reasons << decider.reason
    end
    reasons
  end

  def can_i_bump?
    return false if @deciders.empty?
    @deciders.reduce(true) do |result, decider|
      decider_result = decider.can_i_bump?
      result && decider_result
    end
  end
end