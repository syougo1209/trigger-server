module Mocks::SyudenMock
  SHIBUYA = {
    station_code: 'shibuya',
    station_name: '渋谷駅'
  }

  SHINAGAWA = {
    station_code: 'shinagawa',
    station_name: '品川駅'
  }

  EBISU = {
    station_code: 'ebisu',
    station_name: '恵比寿駅'
  }

  MEGURO = {
    station_code: 'meguro',
    station_name: '目黒駅'
  }

  GOTANDA = {
    station_code: 'gotanda',
    station_name: '五反田駅'
  }

  OSAKI = {
    station_code: 'osaki',
    station_name: '大崎駅'
  }

  NISHIOI = {
    station_code: 'nishioi',
    station_name: '西大井駅'
  }

  MUSASHIKOSUGI = {
    station_code: 'musashikosugi',
    station_name: '武蔵小杉駅'
  }

  SHINKAWASAKI = {
    station_code: 'shinkawasaki',
    station_name: '新川崎駅'
  }

  YOKOHAMA = {
    station_code: 'yokohama',
    station_name: '横浜駅'
  }

  HODOGAYA = {
    station_code: 'hodogaya',
    station_name: '保土ヶ谷駅'
  }

  class << self
    def shibuya_to_hodogaya(date: nil)
      date ||= Time.zone.today
      nextdate = date.tomorrow

      [
        {
          from: SHIBUYA,
          to: HODOGAYA,
          leave_at: Time.new(date.year, date.month, date.day, 22, 29, 0, '+09:00'),
          arrive_at: Time.new(date.year, date.month, date.day, 23, 0, 0, '+09:00'),
          lines: [
            {
              name: '湘南新宿ライン',
              direction: '逗子行',
              track: '4番線',
              from: SHIBUYA,
              to: HODOGAYA,
              leave_at: Time.new(date.year, date.month, date.day, 22, 29, 0, '+09:00'),
              arrive_at: Time.new(date.year, date.month, date.day, 23, 0, 0, '+09:00'),
              stop_stations: [
                EBISU,
                OSAKI,
                NISHIOI,
                MUSASHIKOSUGI,
                SHINKAWASAKI,
                YOKOHAMA
              ]
            }
          ]
        },
        {
          from: SHIBUYA,
          to: HODOGAYA,
          leave_at: Time.new(date.year, date.month, date.day, 23, 38, 0, '+09:00'),
          arrive_at: Time.new(nextdate.year, nextdate.month, nextdate.day, 0, 26, 0, '+09:00'),
          lines: [
            {
              name: '山手線',
              direction: '品川・東京方面（内回り）',
              track: '2番線',
              from: SHIBUYA,
              to: SHINAGAWA,
              leave_at: Time.new(date.year, date.month, date.day, 23, 38, 0, '+09:00'),
              arrive_at: Time.new(date.year, date.month, date.day, 23, 52, 0, '+09:00'),
              stop_stations: [
                EBISU,
                MEGURO,
                GOTANDA,
                OSAKI
              ]
            },
            {
              name: '横須賀線',
              direction: '大船行き',
              track: '15番線',
              from: SHINAGAWA,
              to: HODOGAYA,
              leave_at: Time.new(date.year, date.month, date.day, 23, 59, 0, '+09:00'),
              arrive_at: Time.new(nextdate.year, nextdate.month, nextdate.day, 0, 26, 0, '+09:00'),
              stop_stations: [
                NISHIOI,
                MUSASHIKOSUGI,
                SHINKAWASAKI,
                YOKOHAMA
              ]
            }
          ]
        }
      ]
    end

    def shibuya_to_shinagawa(date: nil)
      date ||= Time.zone.today
      nextdate = date.tomorrow

      [
        {
          from: SHIBUYA,
          to: SHINAGAWA,
          leave_at: Time.new(nextdate.year, nextdate.month, nextdate.day, 0, 13, 0, '+09:00'),
          arrive_at: Time.new(nextdate.year, nextdate.month, nextdate.day, 0, 25, 0, '+09:00'),
          lines: [
            {
              name: '山手線',
              direction: '品川・東京方面（内回り）',
              track: '2番線',
              leave_at: Time.new(nextdate.year, nextdate.month, nextdate.day, 0, 13, 0, '+09:00'),
              arrive_at: Time.new(nextdate.year, nextdate.month, nextdate.day, 0, 25, 0, '+09:00'),
              stop_stations: [
                EBISU,
                MEGURO,
                GOTANDA,
                OSAKI
              ]
            }
          ]
        }
      ]
    end
  end
end
