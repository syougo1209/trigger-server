require 'json'
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
      path = File.expand_path('../mocks/shibuya_to_hodogaya_syuden.json', __FILE__)
      file = File.read(path)
      
      JSON.parse(file, symbolize_names: true)
    end

    def shibuya_to_shinagawa
      File.open("sample.json", "w")
    end
  end
end
