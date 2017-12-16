require 'rails_helper'

RSpec.describe CsRandom, type: :model do
	random = CsRandom.new(123456789)

	describe "attributes" do
		it "has seed value" do
			expect(random).to have_attributes(:seed => 123456789)
		end

		it "has inext and inextp values" do
			expect(random).to have_attributes(:inext => 0)
			expect(random).to have_attributes(:inextp => 21)
		end

		it "has seed_array" do
			# Array is expected to contain the exact same seed_array every time.
			expect(random).to have_attributes(:seed_array => start_with(nil, 398237872, 507112126, 1165939853, 809879929))
			expect(random).to have_attributes(:seed_array => end_with(1833933445, 1472214293, 289669297, 1415461455, 587519354))
		end
	end

	# numbers are expected to be returned in a predictable order
	describe "methods" do
		it "returns doubles in a predictable order" do
			random = CsRandom.new(123456789)
			expect(random.next_double).to equal(0.5083497583439339)
			expect(random.next_double).to equal(0.17781306252712992)
			expect(random.next_double).to equal(0.6219475933452824)
			expect(random.next_double).to equal(0.40299016302590734)
			expect(random.next_double).to equal(0.9167651384681301)

			# Reset
			random = CsRandom.new(123456789)
			expect(random.next_double).to equal(0.5083497583439339)
			expect(random.next_double).to equal(0.17781306252712992)
			expect(random.next_double).to equal(0.6219475933452824)
			expect(random.next_double).to equal(0.40299016302590734)
			expect(random.next_double).to equal(0.9167651384681301)
		end

		it "returns ints in a predictable order" do
			random = CsRandom.new(123456789)
			expect(random.next).to equal(1091672793)
			expect(random.next).to equal(381850644)
			expect(random.next).to equal(1335622286)
			expect(random.next).to equal(865414785)
			expect(random.next).to equal(1968738143)

			# Reset
			random = CsRandom.new(123456789)
			expect(random.next).to equal(1091672793)
			expect(random.next).to equal(381850644)
			expect(random.next).to equal(1335622286)
			expect(random.next).to equal(865414785)
			expect(random.next).to equal(1968738143)
		end
	end
end
