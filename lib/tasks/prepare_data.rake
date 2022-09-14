# frozen_string_literal: true

namespace :prepare_data do
  task apply: :environment do
    puts '== Prepare data =='
    shibuya = Station.create!(code: 'shibuya', name: '渋谷駅')
    shinagawa = Station.create!(code: 'shinagawa', name: '品川駅')
    ebisu = Station.create!(code: 'ebisu', name: '恵比寿駅')
    meguro = Station.create!(code: 'meguro', name: '目黒駅')
    gotanda = Station.create!(code: 'gotanda', name: '五反田駅')
    osaki = Station.create!(code: 'osaki', name: '大崎駅')
    nishiooi = Station.create!(code: 'nishioi', name: '西大井駅')
    musashikosugi = Station.create!(code: 'musashikosugi', name: '武蔵小杉駅')
    shinkawasaki = Station.create!(code: 'shinkawasaki', name: '新川崎駅')
    yokohama = Station.create!(code: 'yokohama', name: '横浜駅')
    hodogaya = Station.create!(code: 'hodogaya', name: '保土ヶ谷駅')

    puts '== Prepare hotel data =='
    Hotel.create!(name: '渋谷東武ホテル', price: 9300, postcode: '150-0042', genre: Hotel.genres[:hotel], station: shibuya)
    Hotel.create!(name: '渋谷東急REIホテル', price: 10800, postcode: '150-0002', genre: Hotel.genres[:hotel], station: shibuya)
    Hotel.create!(name: 'ドーミーインＰＲＥＭＩＵＭ渋谷神宮前', price: 14750, postcode: '150-0001', genre: Hotel.genres[:hotel], station: shibuya)
    Hotel.create!(name: 'マンボー渋谷センター街店', price: 1800, postcode: '150-0042', genre: Hotel.genres[:manga_cafe], station: shibuya)

    Hotel.create!(name: '品川東武ホテル', price: 6700, postcode: '108-0074', genre: Hotel.genres[:hotel], station: shinagawa)
    Hotel.create!(name: '東横ＩＮＮ品川駅高輪口', price: 10300, postcode: '108-0074', genre: Hotel.genres[:hotel], station: shinagawa)
    Hotel.create!(name: '品川プリンスホテル', price: 11690, postcode: '108-8611', genre: Hotel.genres[:hotel], station: shinagawa)
    puts '== finish! =='
  end
end
