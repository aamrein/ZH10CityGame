# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations' || table == 'ar_internal_metadata' || table == 'users'
  ActiveRecord::Base.connection.execute("TRUNCATE #{table} CASCADE")
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH 1")
end

game = Game.create({
                       name: 'Testspiel 1',
                       start: DateTime.parse('10/10/2017 8:00'),
                       duration: 24,
                       amount_per_inhabitants_per_hour: 100
                   }
)

Group.create([
    {game_id: game.id, name: 'Gruppe 1', email: 'gruppe1@gruppe.ch', phone: '', start_balance: 10000},
    {game_id: game.id, name: 'Gruppe 2', email: 'gruppe2@gruppe.ch', phone: '', start_balance: 10000},
    {game_id: game.id, name: 'Gruppe 3', email: 'gruppe3@gruppe.ch', phone: '', start_balance: 10000},
    {game_id: game.id, name: 'Gruppe 4', email: 'gruppe4@gruppe.ch', phone: '', start_balance: 10000}
             ])

categories = Category.create([
                    {name: 'Handel', color: '#008000'},
                    {name: 'Kultur', color: '#a52a2a'},
                    {name: 'Sicherheit', color: '#b08000'},
                    {name: 'Bildung', color: '#777700'},
                    {name: 'Gesundheit', color: '#00bfff'},
                    {name: 'Infrastruktur', color: '#1100aa'}
                ])

market = Building.create(
    {name: 'Markt', inhabitants: 50, construction_duration_sec: 900,
     category_id: categories.select{|c| c[:name] == 'Handel'}.first[:id],
     cost: 80000, cost_per_hour: 30000, income_per_hour: 40000,
     required_building_id: nil,
     comment: 'Auf dem Markt können die Bauern und andere kleine Firmen ihre Produkte verkaufen. Der Mark bietet die Grundlage für weitere Gebäude.'})
shopping_mall = Building.create(
    {name: 'Einkaufszentrum', inhabitants: 100, construction_duration_sec: 7200,
     category_id: categories.select{|c| c[:name] == 'Handel'}.first[:id],
     cost: 250000, cost_per_hour: 110000, income_per_hour: 150000,
     required_building_id: market.id,
     comment: 'Das Einkaufszentrum ist die Erweiterung zum Markt. Ausserdem bringt das Einkaufszentrum grössere Einkünfte.'})
Building.create(
    {name: 'Bank', inhabitants: 150, construction_duration_sec: 12600,
     category_id: categories.select{|c| c[:name] == 'Handel'}.first[:id],
     cost: 450000, cost_per_hour: 220000, income_per_hour: 300000,
     required_building_id: shopping_mall.id,
     comment: 'Die Bank ist zuständig für die Verwaltung des Geldes in der Stadt. Mit ihr kann das Geld besser angelegt werden, was sich sehr positiv auf die Einnahmen pro Stunde auswirkt.'})
parking = Building.create(
    {name: 'Parkanlage', inhabitants: 200, construction_duration_sec: 1800,
     category_id: categories.select{|c| c[:name] == 'Kultur'}.first[:id],
     cost: 70000, cost_per_hour: 10000, income_per_hour: 10000,
     required_building_id: nil,
     comment: 'In der Parkanlage können sich die Stadtbewohner entspannen. Diese ist eine Aufwertung der gesamten Stadt, was sich in den Einwohnerzahlen bemerkbar macht.'})
church = Building.create(
    {name: 'Kirche', inhabitants: 500, construction_duration_sec: 5400,
     category_id: categories.select{|c| c[:name] == 'Kultur'}.first[:id],
     cost: 190000, cost_per_hour: 70000, income_per_hour: 75000,
     required_building_id: parking.id,
     comment: 'Die Kirche ist das Haus Gottes. Diese wertet die Stadt weiter auf und bringt ebenfalls viele Einwohner in die Stadt.'})
museum = Building.create(
    {name: 'Museum', inhabitants: 700, construction_duration_sec: 8000,
     category_id: categories.select{|c| c[:name] == 'Kultur'}.first[:id],
     cost: 300000, cost_per_hour: 85000, income_per_hour: 100000,
     required_building_id: church.id,
     comment: 'Das Museum ist ein Ort, wo sich Künstler präsentieren können. Dies bringt weitere Einwohner in die Stadt und wertet diese auf.'})
Building.create(
    {name: 'Theater', inhabitants: 1000, construction_duration_sec: 12600,
     category_id: categories.select{|c| c[:name] == 'Kultur'}.first[:id],
     cost: 400000, cost_per_hour: 170000, income_per_hour: 200000,
     required_building_id: museum.id,
     comment: 'Das Theater ist ein weiterer Ort, wo sich die Stadtbewohner vergnügen können. Dies lockt weitere Einwohner in die Stadt.'})
police = Building.create(
    {name: 'Polizei', inhabitants: 300, construction_duration_sec: 1800,
     category_id: categories.select{|c| c[:name] == 'Sicherheit'}.first[:id],
     cost: 90000, cost_per_hour: 100000, income_per_hour: 120000,
     required_building_id: nil,
     comment: 'Die Polizei ist zuständig für die Sicherheit. Ohne ihr herrscht Chaos in der Stadt. Ausserdem ist die Polizei die Grundlage für weitere wichtige Gebäude.'})
firefighter = Building.create(
    {name: 'Feuerwehr', inhabitants: 300, construction_duration_sec: 3600,
     category_id: categories.select{|c| c[:name] == 'Sicherheit'}.first[:id],
     cost: 110000, cost_per_hour: 70000, income_per_hour: 70000,
     required_building_id: police.id,
     comment: 'Die Feuerwehr ist zuständig für das löschen von Bränden. Mit ihr können brennende Gebäude schneller und besser gelöscht werden und somit der Schaden in grenzen gehalten werden.'})
prison = Building.create(
    {name: 'Gefängnis', inhabitants: 100, construction_duration_sec: 7200,
     category_id: categories.select{|c| c[:name] == 'Sicherheit'}.first[:id],
     cost: 140000, cost_per_hour: 150000, income_per_hour: 125000,
     required_building_id: firefighter.id,
     comment: 'Das Gefängnis beherbergt die Verbrecher. Mit diesem können auch Attentäter von gegnerischen Gruppen für eine gewisse Zeit aus dem Verkehr gezogen werden. Dies ist jedoch mit Kosten verbunden.'})
Building.create(
    {name: 'Versicherung', inhabitants: 100, construction_duration_sec: 8000,
     category_id: categories.select{|c| c[:name] == 'Sicherheit'}.first[:id],
     cost: 250000, cost_per_hour: 150000, income_per_hour: 200000,
     required_building_id: prison.id,
     comment: 'Die Versicherung sorg dafür, dass die Kosten von beschädigten Gebäuden gedeckt werden. Somit kann im Falle einer Katastrophe sehr viel Geld gespart werden.'})
school = Building.create(
    {name: 'Schule', inhabitants: 200, construction_duration_sec: 3600,
     category_id: categories.select{|c| c[:name] == 'Bildung'}.first[:id],
     cost: 85000, cost_per_hour: 50000, income_per_hour: 50000,
     required_building_id: nil,
     comment: 'Die Schule bildet die Stadtbewohner aus und bietet die Grundlage für die höhere Ausbildung.'})
university = Building.create(
    {name: 'Universität', inhabitants: 1000, construction_duration_sec: 7200,
     category_id: categories.select{|c| c[:name] == 'Bildung'}.first[:id],
     cost: 160000, cost_per_hour: 150000, income_per_hour: 125000,
     required_building_id: school.id,
     comment: 'Die Universität bildet Fachleute aus. Studierte Leute werten die Stadt weiter auf und bringt erhebliche Einwohner in die Stadt.'})
Building.create(
    {name: 'Terrorlager', inhabitants: 0, construction_duration_sec: 10800,
     category_id: categories.select{|c| c[:name] == 'Bildung'}.first[:id],
     cost: 230000, cost_per_hour: 200000, income_per_hour: 160000,
     required_building_id: university.id,
     comment: 'Das Terrorlager bildet Attentäter aus. Mit diesen können dann Attentate oder Spionageangriffe auf die anderen Stadtteile verübt werden.'})
paramedic = Building.create(
    {name: 'Sanität', inhabitants: 300, construction_duration_sec: 2700,
     category_id: categories.select{|c| c[:name] == 'Gesundheit'}.first[:id],
     cost: 90000, cost_per_hour: 50000, income_per_hour: 60000,
     required_building_id: nil,
     comment: 'Die Sanität bietet Erste Hilfe für verletzte Stadtbewohner.'})
Building.create(
    {name: 'Krankenhaus', inhabitants: 700, construction_duration_sec: 5400,
     category_id: categories.select{|c| c[:name] == 'Gesundheit'}.first[:id],
     cost: 120000, cost_per_hour: 100000, income_per_hour: 120000,
     required_building_id: paramedic.id,
     comment: 'Das Krankenhaus versorgt die kranken und verletzten Stadtbewohner.'})
water_supply = Building.create(
    {name: 'Wasserversorgung', inhabitants: 200, construction_duration_sec: 1800,
     category_id: categories.select{|c| c[:name] == 'Infrastruktur'}.first[:id],
     cost: 70000, cost_per_hour: 50000, income_per_hour: 57000,
     required_building_id: nil,
     comment: 'Die Wasserversorgung versorgt alle Stadtbewohner mit frischem Wasser. Dieses Gebäude ist erforderlich für den Bau von mehr als 5 Gebäuden.'})
energy_supply = Building.create(
    {name: 'Stromversorgung', inhabitants: 300, construction_duration_sec: 3600,
     category_id: categories.select{|c| c[:name] == 'Infrastruktur'}.first[:id],
     cost: 80000, cost_per_hour: 80000, income_per_hour: 90000,
     required_building_id: water_supply.id,
     comment: 'Die Stromversorgung versorgt alle Stadtbewohner mit Strom. Dieses Gebäude ist erforderlich für den Bau von mehr als 10 Gebäuden.'})
Building.create(
    {name: 'Verkehrsnetz', inhabitants: 400, construction_duration_sec: 5400,
     category_id: categories.select{|c| c[:name] == 'Infrastruktur'}.first[:id],
     cost: 180000, cost_per_hour: 170000, income_per_hour: 180000,
     required_building_id: energy_supply.id,
     comment: 'Das Verkehrsnetz sorgt dafür, dass alle Stadtbewohner sich schneller fortbewegen können. Dieses Gebäude ist erforderlich für den Bau von mehr als 15 Gebäuden.'})

Event.create([
    {name: 'Erdbeben', impact_percent: 80, duration_sec: 600,
     comment: 'Das Erdbeben beschädigt alle Gebäude. Der Zustand wird auf 80% reduziert.'}
             ])

ConstructedBuilding.create([
    {building_id: 1, group_id: 1, construction_time: DateTime.parse('10/10/2017 8:10')},
    {building_id: 8, group_id: 1, construction_time: DateTime.parse('10/10/2017 8:15')}
                           ])

EventLog.create([
    {constructed_building_id: 1, event_id: 1, start: DateTime.parse('10/10/2017 8:15'), comment: ''}
                ])