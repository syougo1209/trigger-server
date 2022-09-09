create_table "hotels", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  t.bigint  "station_id", null: false, unsigned: true
  t.string  "name",       null: false
  t.integer "price",      null: false
  t.float   "latitude",   null: false
  t.float   "longitude",  null: false
  t.integer "genre",    null: false

  t.timestamps
end

add_index       "hotels", %w[station_id], name: "idx_hotels_on_station_id"
add_foreign_key "hotels", "stations",      name: "fk_hotels_1"
