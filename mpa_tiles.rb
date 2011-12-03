# encoding: UTF-8

require 'sinatra'
require 'sqlite3'
require 'haml'
require 'geocoder'

get '/tiles/:zoom/:column/:row' do
  content_type 'image/png'
  
  # flip round the y coordinate for mapbox
  y = ((2**params[:zoom].to_f) - 1) - params[:row].to_f
  
  
  db = SQLite3::Database.new "data/Mexico.mbtiles"
  rows = db.execute("select images.tile_data 
                     from map 
                     inner join images 
                     on (map.tile_id = images.tile_id) 
                     where zoom_level = #{params[:zoom]} AND 
                     tile_row = #{y} AND 
                     tile_column = #{params[:column]}")
  
  rows[0][0] unless rows.empty?
end

get '/' do
  haml :index
end

def geo_code query
  Geocoder::Configuration.lookup = :yahoo
  Geocoder.coordinates(query)
end

get '/json.json' do
  content_type 'application/json', :charset => 'utf-8'
  ['Nuevo Leon', 'Sonora', 'Yucatan'].map do |state|
    {:name => state, :attributes => {"Educación" => rand(40) + 10, "Salud" => rand(60) + 10 }}
  end.to_json
end

