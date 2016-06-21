require 'fileutils'
Dir.glob(File.dirname(File.absolute_path(__FILE__)) + '/rules/*') { |file| require file }

class InitialSetup
  def self.rules
    [
      AttributeRule.new(nationality: 'British', color: 'Red', description: 'The Brit lives in the house with red walls'),
      AttributeRule.new(nationality: 'Swede', animal: 'Dog', description: 'The Swede has a dog'),
      AttributeRule.new(nationality: 'Dane', drink: 'Tea', description: 'The Dane drinks tea'),
      OnTheLeftRule.new(left_attribute: { color: 'Green' }, right_attribute: { color: 'White' }, description: 'The house with green wall is directly to the left of the house with white walls'),
      AttributeRule.new(color: 'Green', drink: 'Coffee', description: 'The owner of the house with green walls drinks coffee'),
      AttributeRule.new(cigar: 'Pall Mall', animal: 'Bird', description: 'The person who smokes Pall Mall cigars owns a bird'),
      AttributeRule.new(color: 'Yellow', cigar: 'Dunhill', description: 'The owner of the house with yellow walls smokes Dunhill cigars'),
      CenterColumnRule.new(drink: 'Milk', description: 'The man living in the center house drinks milk'),
      ColumnRule.new(nationality: 'Norwegian', column: 1, description: 'The Norwegian lives in the first house'),
      NeighborRule.new(cigar: 'Blend', animal: 'Cat', description: 'The man who smokes Blends lives next to the cat owner'),
      NeighborRule.new(animal: 'Horse', cigar: 'Dunhill', description: "The horse's owner lives next to the man who smokes Dunhill"),
      AttributeRule.new(cigar: 'Blue Master', drink: 'Root Beer', description: 'The man who smokes Blue Master drinks root beer'),
      AttributeRule.new(nationality: 'German', cigar: 'Prince', description: 'The German smokes Prince'),
      NeighborRule.new(nationality: 'Norwegian', color: 'Blue', description: 'The Norwegian lives next to the house with blue walls'),
      NeighborRule.new(cigar: 'Blend', drink: 'Water', description: 'The man who smokes Blends has a next-door neighbor who drinks water')
    ]
  end

  def self.attributes
    ['Color', 'Nationality', 'Cigar', 'Drink', 'Animal']
  end

  def self.columns
    ['House 1', 'House 2', 'House 3', 'House 4', 'House 5']
  end

  def self.build_initial_matrix
    content = []
    content << ['-'] + columns

    attributes.each do |attribute|
      line = [attribute]
      columns.each do |_|
        line << ''
      end
      content << line
    end

    Table.rows(content)
  end
end
