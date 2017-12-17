require 'rails_helper'

RSpec.describe ToolsHelper, :type => :helper do
	game_id = 123456789
	day = 1

	describe "elevator" do
		it "returns the elevator levels" do
			expect(elevator).to contain_exactly(5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120)
		end
	end

	describe "override" do
		it "returns monster infestations levels that get overridden" do
			expect(override).to contain_exactly(1, 2, 3, 4, 5, 19, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 
																					41, 42, 43, 44, 45, 59, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 
																					81, 82, 83, 84, 85, 99, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120)
		end
	end

	describe "monster" do
		it "returns the monster infestation levels" do
			expect(monster(game_id, day)).to contain_exactly(52, 96)
		end
	end

	describe "slime" do
		it "returns the slime infestation levels" do
			expect(slime(game_id, day)).to contain_exactly(6, 29)
		end
	end

	describe "mushroom" do
		it "returns the mushroom levels" do
			expect(mushroom(game_id, day)).to contain_exactly(98, 118)
		end
	end
end