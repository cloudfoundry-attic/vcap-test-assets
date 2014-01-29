module Decider
  class Jenkins
    attr_reader :reason

    def initialize
      @value == "no"
      @reason = "Jenkins: no data yet"
    end

    def can_i_bump?
      @value == "yes"
    end

    def set_can_i_bump(value, reason)
      @reason = reason
      @value = value
    end
  end
end