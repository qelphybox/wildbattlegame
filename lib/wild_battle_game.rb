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
      @log_file = File.new("#{File.dirname(__FILE__)}/../logs/battle_#{next_log_count}.log", 'w')
    end

    def turn
      @warriors.each do |w|
        next if w.hp < 0
        logger "\n#{w.name} атакует:"
        logger '-' * 35
        @warriors.each do |j|
          next if j == w || j.hp < 0
          buf = "#{w.name} бьет #{j.name} | "
          j.hit(w.dmg)
          buf << "Урон #{w.dmg}, #{j.name}: #{j.hp <= 0 ? 'убит' : j.hp.to_s + ' хп'}"
          logger buf
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

    def logger(msg)
      @state[-1..-7] != 'победил' ? @log_file.write("#{msg}\n") : @log_file.close
    end

    def next_log_count
      Dir["#{File.dirname(__FILE__)}/../logs/battle_*.log"].map { |f| File.basename(f)[/\d+/].to_i }.max.next
    end
  end
end
