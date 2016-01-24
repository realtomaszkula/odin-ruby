require_relative '../cipher.rb'

describe "cipher" do
    before :all do
        @test = "aAzZ abc"
        @ciphered = cipher(@test, 3)
    end

    context "given a string" do
      it "returns the same length" do
        expect(@test.size).to eql(@ciphered.size)
      end

      it "changes the string" do
        expect(@test).to_not eql(@ciphered)
      end

      it "doesnt change spaces" do
        expect(@ciphered[4]).to eql(@test[4])
      end

      it "changes by given step" do
        expect(@ciphered[0]).to eql("d")
        expect(@ciphered[1]).to eql("D")
        expect(@ciphered[2]).to eql("c")
        expect(@ciphered[3]).to eql("C")
      end
    end
end

