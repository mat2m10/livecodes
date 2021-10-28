class SlotMachine
  def initialize
    @reel_one = score_guide.keys.sample(1)
    @reel_two = score_guide.keys.sample(1)
    @reel_three = score_guide.keys.sample(1)
  end

  def score_guide
    return {
      joker: 50,
      star: 40,
      bell: 30,
      seven: 20,
      cherry: 10
    }
  end

  def print_reels
    return "| #{@reel_one.join.upcase} | #{@reel_two.join.upcase} | #{@reel_three.join.upcase} |"
  end

  def count_reels
    reels_count_hash = Hash.new(0)
    reels_count_hash[@reel_one] += 1
    reels_count_hash[@reel_two] += 1
    reels_count_hash[@reel_three] += 1
    return reels_count_hash.sort_by { |key, value| -value }.to_h
  end

  def calc_score
    score_triples = score_guide
    count_hash = count_reels
    item = count_hash.keys.first.join.to_sym
    return 0 if count_hash.values.all?(1) || count_hash.keys.none?([:joker])

    if count_hash.values.include?(3)
      return score_triples[item]
    elsif count_hash.values.include?(2) && count_hash.keys.include?([:joker])
      return score_triples[item] / 2
    end
  end
end
