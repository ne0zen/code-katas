#!/usr/bin/env ruby

module Bowling
  class Frame
    attr_accessor :prev_frame
    attr_accessor :rolls

    def initialize(prev_frame=nil)
      @prev_frame = prev_frame
      @rolls = []
    end

    def roll(number)
      rolls << number
    end
    
    def game_score
      last_score = prev_frame.nil? ? 0 : prev_frame.game_score

      frame_score.nil? ? nil : last_score + frame_score
    end

    def last_score
      prev_frame.nil? ? 0 : prev_frame.game_score
    end
    
    def spare?
      open_total == 10 and num_rolls > 1
    end

    def strike?
      open_total == 10 and num_rolls == 1
    end

    def num_rolls
      rolls.size
    end

    def next_frame
      @next_frame ||= Frame.new(self)
    end

    def next_roll
      next_frame.num_rolls > 0 ?  next_frame.rolls[0] : nil
    end

    private

    # returns:
    # nil if more rolls are needed to calculate this frame's score
    # otherwise returns an integer representing either:
    # 
    # if strike: number of pins knocked down in first two rolls of next frame + 10
    # or
    # if spare: number of pins knocked down in next roll frame's first roll + 10
    # or
    # number of pins knocked down in this frame
    def frame_score
      if rolls.empty? or (num_rolls < 2 and not strike?)
         nil
      elsif spare?
        10 + next_roll rescue nil
      elsif strike?
        10 + next_two_rolls rescue nil
      else
        open_total
      end
    end

    def next_two_rolls
      if next_frame.num_rolls > 1
        next_roll + next_frame.rolls[1]
      else
        next_roll + next_frame.next_frame.next_roll rescue nil
      end
    end
    
    def open_total
      rolls.reduce(0, &:+)
    end
  end
end
