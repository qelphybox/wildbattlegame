# encoding: utf-8

module WildBattleGame
  class Warrior
    attr_reader :hp, :dmg, :name
    def initialize(name, hp = 100, dmg = 1)
      @name = name
      @hp = hp
      @dmg = dmg
    end

    def hit(dmg = 1)
      @hp -= dmg
    end
  end

  class Battle
    attr_reader :warriors, :turns, :state
    def initialize(*warriors)
      @warriors = warriors
      @turns = 0
      @state = "Только началась"
    end

    def turn
      @warriors.each do |w|
        next if w.hp < 0
        puts "\n#{w.name} атакует:"
        puts '-' * 35
        @warriors.each do |j|
          next if j == w || j.hp < 0
          print "#{w.name} бьет #{j.name} | "
          j.hit(w.dmg)
          puts "Урон #{w.dmg}, #{j.name}: #{j.hp <= 0 ? 'убит' : j.hp.to_s + ' хп'}"
        end
      end
      @turns += 1
      eval_state
    end

    private

    def eval_state
      wars = @warriors.select { |w| w.hp > 0 }
      @state = wars.count > 1 ? "В разгаре" : "#{wars[0].name} - победил"
    end
  end
end
