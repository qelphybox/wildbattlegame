# encoding: utf-8

module WildBattleGame
  module BattleGenerator
    def generate_battle
      names = %w(Афанасий Коленвал Батлмэйстер Губернатор СамИисус Оксимирон БаронФонТриппербах Гумен).shuffle
      n = rand(2..10).times { |i| instance_variable_set("@war#{i}", Warrior.new(names.pop, rand(50..100), rand(1..20))) }
      war_str = Array.new(n) { |i| "@war#{i}" }.join(', ')
      eval("Battle.new(#{war_str})")
    end
  end
end
