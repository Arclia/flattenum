
require 'flattenum'

wrap_these = [1, "hello", {foo: "bar"}, Object.new]

describe Flattenum do

  describe '#should_flatten?' do 

    it 'returns something truthy when given an Array' do 
      expect(Flattenum.should_flatten?([1, 2, 3])).to be_truthy
    end

    it 'returns something truthy when given an Enumerator' do 
      expect(Flattenum.should_flatten?({foo: 3, bar: 3}.to_enum)).to be_truthy
    end

    wrap_these.each do |input|
      it "returns something falsey when given a #{input.class.name} instance" do 
        expect(Flattenum.should_flatten?(input)).to be_falsey
      end
    end

  end

  describe '#flattenum' do 

    context 'Flattenum.should_flatten?(input) is falsey' do 

      wrap_these.each do |input|
        it "wraps #{input.class.name} instances with an Enumerator" do 
          enum = ::Flattenum.this(input)

          expect(enum).to be_an(Enumerator)
          expect(enum.next).to equal(input)

          expect{enum.next}.to raise_exception(StopIteration)
        end
      end

    end


    context 'Flattenum.should_flatten?(input) is truthy' do

      it 'recursively flattens the input' do
        x = [1, "foo", {bar: 3}, Object.new, Object, 3, 4.2]
        enum = ::Flattenum.this([x[0], x[1], [x[2], x[3], x[4]].to_enum, [[[x[5]]], x[6]]])

        x.each do |y|
          expect(enum.next).to equal y
        end
        expect{enum.next}.to raise_exception(StopIteration)
      end
    end


  end
end
