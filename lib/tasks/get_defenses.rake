require 'rubygems'
require 'mechanize'
require 'pp'

desc 'Grabs all the information for defenses because they are ranked outside of get_rankings'
task :get_defense, :needs => :environment  do |t, args| 
  begin
    @agent = Mechanize.new
    @page_count = 0 #variable to deal with pagination
    @players = [] 

      page = @agent.get("http://games.espn.go.com/ffl/tools/projections?startIndex&slotCategoryId=16")
      cell_counter = 0 
      player = {}

      page.search('tr .pncPlayerRow td').to_a.each do |cell|
        key = case cell_counter
              when 0  then :rank
              when 1  then :name
              when 2  then :c_a
              when 3  then :pass_yds
              when 4  then :pass_td
              when 5  then :int
              when 6  then :rush
              when 7  then :rush_yds
              when 8  then :rush_tds
              when 9  then :receptions
              when 10 then :rec_yds
              when 11 then :rec_tds
              when 12 then :points

              end

        player[key] = cell.text unless key == :ignore
        cell_counter += 1

        # reached end of row: add to players array
        if cell_counter == 13

          @players << player

          # reset local variables for next item
          player = {}
          cell_counter = 0
        end
      end
      
   get_ranking_defenses = Player.available.by_position("D/S").order("rank")
   @existing_defense = []
   @player_count = Player.count
   
   get_ranking_defenses.each do |existing_player|   
     @existing_defense << existing_player.first_name 
   end
   
     @players.each do |player|
        next if @existing_defense.include?(player[:name].split(',')[0].split[0].strip.gsub(' ', '')) #first_name = "Bears" "Packers" etc

       pl = Player.new
       
       pl.rank = player[:rank].to_i + @player_count
       pl.first_name = player[:name].split(',')[0].split[0].strip.gsub(' ', '')  #first name
       pl.last_name =  player[:name].split(',')[0].split[1].strip.gsub(' ', '')   #last name
       
        s = player[:name].split(',')[1].strip.gsub(' ', '') 
            pl.position = "D/S"     # Position    
            pl.selected = false
         pl.save
     end
  rescue StandardError => e
    puts e.backtrace
  end
end
