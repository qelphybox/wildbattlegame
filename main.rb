# encoding: utf-8

Dir['./lib/*.rb'].each { |d| require d }

include WildBattleGame::BattleGenerator

@battle = WildBattleGame::BattleGenerator.generate_battle

puts "Воины:"
@battle.warriors.each { |w| puts "  #{w.name} (Здоровье: #{w.hp}, Урон: #{w.dmg})" }
puts '=' * 35

loop do
  @battle.turn
  break if @battle.state[-7..-1] == 'победил'
end

puts "\nРезультат: \"#{@battle.state}\" (#{@battle.warriors.find { |i| i.hp > 0 }.hp} хп)"
