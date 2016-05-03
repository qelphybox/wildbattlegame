# encoding: utf-8

Dir['./lib/*.rb'].each { |d| require d }

include WildBattleGame::BattleGenerator

@battle = WildBattleGame::BattleGenerator.generate_battle

loop do
  @battle.turn
  break if @battle.state[-7..-1] == 'победил'
end
