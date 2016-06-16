require 'fileutils'
Dir.glob(File.dirname(File.absolute_path(__FILE__)) + '/rules/*') { |file| require file }

class InitialSetup
  def self.rules
    [
      RedWallsRule.new,
      SwedeAnimalRule.new,
      DaneDrinkRule.new,
      GreenWhiteRule.new,
      GreenWallDrinkRule.new,
      PallMallAnimalRule.new,
      YellowWallCigarRule.new,
      CenterHouseDrinkRule.new,
      NorwegianRule.new,
      CatNeighborRule.new,
      HorseNeighborRule.new,
      BlueMasterDrinkRule.new,
      GermanCigarRule.new,
      NorwegianNeighborRule.new,
      BlendSmokerNeighborRule.new
    ]
  end
end
