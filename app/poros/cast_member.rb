class CastMember
  attr_reader :character, :actor

  def initialize(cast_data)
    @character = cast_data[:character]
    @actor = cast_data[:name]
  end
end
