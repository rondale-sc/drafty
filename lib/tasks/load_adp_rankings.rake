require 'rubygems'
require 'mechanize'
require 'pp'

desc 'Grabs all the rank information from the My Fantasy League ADP Site.'
task :load_adp_rankings, :needs => :environment  do |t, args|
  @agent = Mechanize.new
  @players = []

  @bye_weeks = {
    'DAL' => 4,
    'KCC' => 4,
    'MIN' => 4,
    'TBB' => 4,
    'MIA' => 5,
    'NEP' => 5,
    'PIT' => 5,
    'SEA' => 5,
    'ARI' => 6,
    'BUF' => 6,
    'CAR' => 6,
    'CIN' => 6,
    'DET' => 7,
    'HOU' => 7,
    'IND' => 7,
    'NYJ' => 7,
    'ATL' => 8,
    'BAL' => 8,
    'CHI' => 8,
    'CLE' => 8,
    'NYG' => 8,
    'PHI' => 8,
    'DEN' => 9,
    'JAC' => 9,
    'SFO' => 9,
    'STL' => 9,
    'TEN' => 9,
    'WAS' => 9,
    'GBP' => 10,
    'NOS' => 10,
    'OAK' => 10,
    'SDC' => 10
  }

  page = @agent.get("http://football.myfantasyleague.com/#{Time.now.year}/adp?COUNT=500&POS=*&CUTOFF=5&FRANCHISES=-1&IS_PPR=-1&IS_KEEPER=0&IS_MOCK=-1&TIME=")

  rows = page.search('table.report tr')

  rows.each do |row|
    next if row.search('th').length > 0
    player = {}

    cells = row.css('td')

    cells.each_with_index do |value, index|
      field = case index
              when 0
                :rank
              when 1
                :player
              when 2
                :average_pick
              when 3
                :minimum_pick
              when 4
                :maximum_pick
              when 5
                :drafts_selected_in
              end

      player[field] = value.text
      if field == :player
        player[:url]  = "http://football.myfantasyleague.com/#{Time.now.year}/" + value.children[0].attributes['href'].value
      end
    end

    player[:player] =~ /(.+),\s(.+)\s(.{3})\s(.{2,3})/
    player[:last_name] = $1
    player[:first_name] = $2
    player[:nfl_team] = $3
    player[:position] = $4

    player[:bye_week] = @bye_weeks[player[:nfl_team]]

    @players << player
  end

  @players.each do |player|
    attributes = player.reject{|k,v| [:player, :drafts_selected_in].include? k }
    Player.create(attributes)
  end
end
