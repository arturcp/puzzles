require 'fileutils'
Dir.glob(File.dirname(File.absolute_path(__FILE__)) + '/rules/*') { |file| require file }

class InitialSetup
  def self.rules
    [
      RedWallsRule,
      SwedeAnimalRule,
      DaneDrinkRule,
      GreenWhiteRule,
      GreenWallDrinkRule,
      PallMallAnimalRule,
      YellowWallCigarRule,
      CenterHouseDrinkRule,
      NorwegianRule,
      CatNeighborRule,
      HorseNeighborRule,
      BlueMasterDrinkRule,
      GermanCigarRule,
      NorwegianNeighborRule,
      BlendSmokerNeighborRule
    ]
  end
end
