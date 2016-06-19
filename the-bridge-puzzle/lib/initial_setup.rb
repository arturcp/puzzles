require_relative 'character'

class InitialSetup
  def self.characters
    [
      Character.new('Me', 1),
      Character.new('Lab assistant', 2),
      Character.new('Janitor', 5),
      Character.new('Professor', 10)
    ]
  end
end
