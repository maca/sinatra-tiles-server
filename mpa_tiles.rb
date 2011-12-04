# encoding: UTF-8

require 'sinatra'
require 'sqlite3'
require 'haml'
require 'geocoder'
require 'json'
require 'geocoder'

# Geocoder::Configuration.lookup = :yahoo

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

DATA = ['Nuevo Leon', 'Sonora', 'Yucatan', 'DF'].map do |state|
  lng, lat   = Geocoder.coordinates("#{state}, Mexico")
  geometry   = {:type => 'Point', :coordinates => [lat, lng]}
  properties = {"Educación" => rand(40) + 10, "Salud" => rand(60) + 10 }
  {:id => state, :type => 'Feature', :geometry => geometry, :properties => properties}
end

DATA = [
  {:id=>"Nuevo Leon", :type=>"Feature", :geometry=>{:type=>"Point", :coordinates=>[-99.54509739999999, 25.7276624]}, :properties=>{"Educación"=>26, "Salud"=>36}}, 
  {:id=>"Sonora", :type=>"Feature", :geometry=>{:type=>"Point", :coordinates=>[-110.3308814, 29.2972247]}, :properties=>{"Educación"=>28, "Salud"=>65}}, 
  {:id=>"Yucatan", :type=>"Feature", :geometry=>{:type=>"Point", :coordinates=>[-89.0943377, 20.7098786]}, :properties=>{"Educación"=>13, "Salud"=>11}}, 
  {:id=>"DF", :type=>"Feature", :geometry=>{:type=>"Point", :coordinates=>[-99.133208, 19.4326077]}, :properties=>{"Educación"=>19, "Salud"=>32}}
]

get '/json' do
  content_type 'application/json', :charset => 'utf-8'

  bb  = params[:bbox].split(',')
  lng = Range.new(*[bb[0], bb[2]].map(&:to_f).sort)
  lat = Range.new(*[bb[1], bb[3]].map(&:to_f).sort)
  data = DATA.select do |element|
    coordinates = element[:geometry][:coordinates]
    lat.include?(coordinates.first) && lng.include?(coordinates.last) 
  end
  {:type => 'FeatureCollection', :features => data}.to_json
end
