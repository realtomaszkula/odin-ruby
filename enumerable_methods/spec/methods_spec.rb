require_relative '../methods'

describe Enumerable do
  let(:arr) { [1,2,3,4,5,6] }

  describe '#my_count' do
    context 'it returns a number' do
      it { expect(arr.my_count).to be_an_instance_of Fixnum }
    end

    context 'with non Enumerable object' do
      it { expect { 5.my_count }.to raise_error NoMethodError}
      it { expect { nil.my_count }.to raise_error NoMethodError}
      it { expect { "asd".my_count }.to raise_error NoMethodError}
    end

    context 'with no args given' do
      it 'returs the size' do
        expect(arr.my_count).to eql(arr.size)
      end
    end

    context 'with block given' do
      let(:block) { proc {|x| x.even? } }
      it 'counts only even numbers' do
        expect(arr.my_count(&block)).to eql 3
      end
    end

    context 'with number given' do
      it 'counts the number' do
        expect(arr.my_count(2)).to eql 1
      end
    end
  end

  describe '#my_select' do
    context 'returns an array' do
      it { expect(arr.my_select { |x| x } ).to be_an_instance_of Array }
    end

    context 'with non Enumerable object' do
      it { expect { 5.my_count }.to raise_error NoMethodError}
      it { expect { nil.my_count }.to raise_error NoMethodError}
      it { expect { "asd".my_count }.to raise_error NoMethodError}
    end

    context 'when object has elements' do
      it { expect(arr.my_select { |x| x > 5 } ).to eql [6] }
      it { expect(arr.my_select { |x| x > 3 } ).to eql [4,5,6] }
      it { expect(arr.my_select { |x| x > 10 } ).to eql [] }
    end
  end

  describe '#my_all?' do

    context 'with non Enumerable object' do
      it { expect { 5.my_count }.to raise_error NoMethodError}
      it { expect { nil.my_count }.to raise_error NoMethodError}
      it { expect { "asd".my_count }.to raise_error NoMethodError}
    end

    context 'returns true or false' do
      it { expect(arr.my_all? { |x| x.class == Fixnum }).to be_an_instance_of TrueClass}
      it { expect(arr.my_all? { |x| x.class == String  }).to be_an_instance_of FalseClass}
    end
  end

  describe '#my_none?' do
    context 'with non Enumerable object' do
      it { expect{ nil.my_none? }.to raise_error NoMethodError }
      it { expect{ 5.my_none? }.to raise_error NoMethodError }
      it { expect{ "asd".my_none }.to raise_error NoMethodError}
    end

    context 'returns true or false' do
      it { expect(arr.my_none? { |x| x.class == String }).to be_an_instance_of TrueClass }
      it { expect(arr.my_none? { |x| x.class == Fixnum }).to be_an_instance_of FalseClass }
    end
  end

  describe '#my_inject' do
    context 'with non Enumerable Object' do
        it { expect{ nil.my_inject{|sum, x| sum += x } }.to raise_error NoMethodError }
        it { expect{ 5.my_inject{|sum, x| sum += x } }.to raise_error NoMethodError }
        it { expect{ "asd".my_inject{|sum, x| sum += x } }.to raise_error NoMethodError }
    end

    context 'returns a number' do
      it { expect(arr.my_inject {|sum,x| sum += x}).to be_an_instance_of Fixnum }
    end

    context 'with no arg passed' do
      it 'first element used as initial value of memo' do
        expect( arr.my_inject {|sum, x| sum += x }).to eql 21
      end
    end

    context 'with arg passed' do
      it 'first argument passed is used as initial value of memo' do
        expect( arr.my_inject(25){|sum, x| sum += x }).to eql 46
      end
    end
  end

end