create_table "stations", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  t.string "code",      null: false, limit: 100
  t.string "name",      null: false
  t.float  "latitude",  null: false
  t.float  "longitude", null: false

  t.timestamps
end
