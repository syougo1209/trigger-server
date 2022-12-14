require 'mocks/syuden_mock'

class TrainRouteClient
  include Mocks::SyudenMock

  class << self
    def request(station_code_from:, station_code_to:, is_next_day: false)
      if is_next_day
        if  station_code_to == 'hodogaya'
          if station_code_from == 'shibuya'
            shibuya_to_hodogaya_morning
          elsif station_code_from == 'shinagawa'
            shinagawa_to_hodogaya_morning
          end
        end
      else
        if  station_code_from == 'shibuya'
          if station_code_to == 'hodogaya'
            shibuya_to_hodogaya
          elsif station_code_to == 'shinagawa'
            shibuya_to_shinagawa
          end
        end
      end
    end

    private

    def shibuya_to_hodogaya
      Mocks::SyudenMock.shibuya_to_hodogaya
    end

    def shibuya_to_shinagawa
      Mocks::SyudenMock.shibuya_to_shinagawa
    end

    def shibuya_to_hodogaya_morning
      Mocks::SyudenMock.shibuya_to_hodogaya_morning
    end

    def shinagawa_to_hodogaya_morning
      Mocks::SyudenMock.shinagawa_to_hodogaya_morning
    end
  end
end
