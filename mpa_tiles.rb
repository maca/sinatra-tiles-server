# encoding: UTF-8

require 'sinatra'
require 'sqlite3'
require 'haml'
require 'json'

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

get '/json' do
  content_type 'application/json'#, :charset => 'utf-8'
  {:name => 'Nuevo León', :x => 25.67, :y => -100.30, :attributes => {:education => 30, 'health' => 60}}.to_json
end

