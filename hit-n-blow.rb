#!/usr/bin/env ruby

module HitAndBlow
  class Game
    NUMERICS = Array.new(10) { |n|  n.to_s }

    def initialize(digits)
      raise RangeError  unless 1 <= digits && digits <= 10

      @digits  = digits
      @pattern = Regexp.new("[0-9]{#{@digits}}")
    end

    def build
      @answer = NUMERICS.shuffle.slice(0, @digits).join('')
    end

    def verify(value)
      return false  unless @digits == value.length
      return @pattern.match(value)
    end

    def is_match(value)
      return @answer == value
    end

    def check_hit_blow(value)
      hit  = 0
      blow = 0

      @digits.times do |y|
        @digits.times do |x|
          if value[y] == @answer[x]
            if y == x
              hit += 1
            else
              blow += 1
            end
          end
        end
      end

      return { hit: hit, blow: blow }
    end
  end

  class ConsoleRunner
    def initialize(digits = 4)
      @digits = digits
      @game   = Game.new(@digits)
    end

    def run
      @game.build

      puts "Guess the number!"

      while true
        input = gets.chomp

        unless @game.verify(input)
          puts "invalid value. #{@digits} digits numeric value only."
          next
        end

        if @game.is_match(input)
          puts "You win!"
          break
        end

        hint = @game.check_hit_blow(input)
        puts "#{hint[:hit]} hit, #{hint[:blow]} blow"
      end
    end
  end
end

########################################
# execute myself
########################################

if __FILE__ == $0
  include HitAndBlow

  ConsoleRunner.new.run
end
