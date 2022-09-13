require 'mocks/syuden_mock'

class TrainRouteClient
  include Mocks::SyudenMock

  class << self
    def request(station_code_from:, station_code_to:)
      if  station_code_from == 'shibuya'
        if station_code_to == 'hodogaya'
          shibuya_to_hodogaya
        elsif station_code_to == 'shinagawa'
          shibuya_to_shinagawa
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
  end
end
