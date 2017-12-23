require 'rails_helper'
RSpec.describe CalendarsHelper, type: :helper do
	describe "year" do
		it "returns the year in game" do
			day = 1
			expect(year(day)).to eq(1)
			day += 112 * 10
			expect(year(day)).to eq(11)
		end
	end

	describe "season" do
		it "returns the season in game" do
			day = 1
			expect(season(day)).to eq("Spring")
			day += 28
			expect(season(day)).to eq("Summer")
			day += 28
			expect(season(day)).to eq("Fall")
			day += 28
			expect(season(day)).to eq("Winter")
			day += 50
			expect(season(day)).to eq("Spring")
		end
	end
end