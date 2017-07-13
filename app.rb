require 'bundler'
Bundler.require

conn = PGconn.open(dbname: 'clothing')

get '/ascots' do
  content_type :json

  res = conn.exec('SELECT id, brand, pattern, image_url, price FROM ascots;')
  ascots = []
  res.each do |ascot|
    ascots.push(ascot)
  end
  ascots.to_json
end

get '/ascots/:id' do
  id = params[:id]
  res = conn.exec("SELECT id, brand, pattern, image_url, price FROM ascots WHERE id = #{id};")
  ascot = res[0]
  ascot.to_json
end

post '/ascots' do
  #create a new ascot using the request body
  new_ascot = JSON.parse(request.body.read)
  p new_ascot
  brand = new_ascot["brand"]
  pattern = new_ascot["pattern"]
  image_url = new_ascot["image_url"]
  price = new_ascot["price"]
  conn.exec("INSERT INTO ascots (brand, pattern, image_url, price)
            VALUES ('#{brand}', '#{pattern}', '#{image_url}', '#{price}');")
  "success"
end

patch '/ascots/:id' do
  id = params[:id]
  updated_ascot = JSON.parse(request.body.read)
  brand = updated_ascot["brand"]
  pattern = updated_ascot["pattern"]
  image_url = updated_ascot["image_url"]
  price = updated_ascot["price"]

  conn.exec("UPDATE ascots SET brand = '#{brand}', pattern = '#{pattern}',
            image_url = '#{image_url}', price = #{price} WHERE id = #{id}")

  "success"
end

delete '/ascots/:id' do
  p params
  id = params["id"]
  conn.exec("DELETE FROM ascots WHERE id = #{id};")
  "success"
end
