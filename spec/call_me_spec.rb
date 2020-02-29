# frozen_string_literal: true

RSpec.describe CallMe do
  it "has a version number" do
    expect(CallMe::VERSION).not_to be nil
  end

  describe ".call" do
    let(:test_class) do
      Class.new do
        include CallMe

        def call; end
      end
    end

    it "creates an instance of the class" do
      allow(test_class).to receive(:new).and_call_original

      test_class.call
      expect(test_class).to have_received(:new)
    end

    it "invokes the instance's #call method" do
      test_instance = test_class.new
      allow(test_class).to receive(:new).and_return test_instance
      allow(test_instance).to receive(:call).and_call_original

      test_class.call
      expect(test_instance).to have_received(:call)
    end

    it "returns the result of the instance's #call method" do
      expected_result = double :result
      test_instance = instance_double test_class, :test_instance, call: expected_result
      allow(test_class).to receive(:new).and_return test_instance

      expect(test_class.call).to be expected_result
    end

    context "with positional arguments" do
      let(:arguments) { [ double(:first_argument), double(:second_argument) ] }

      it "passes the arguments to the initializer" do
        test_instance = test_class.new
        allow(test_class).to receive(:new).and_return test_instance

        test_class.call(*arguments)
        expect(test_class).to have_received(:new).with(*arguments)
      end

      it "does not pass the arguments to the instance's #call method" do
        test_instance = test_class.new
        allow(test_class).to receive(:new).and_return test_instance
        allow(test_instance).to receive(:call)

        test_class.call(*arguments)
        expect(test_instance).to have_received(:call).with no_args
      end
    end

    context "with keyword arguments" do
      let(:arguments) { { first: double(:first_argument), second: double(:second_argument) } }

      it "passes the arguments to the initializer" do
        test_instance = test_class.new
        allow(test_class).to receive(:new).and_return test_instance

        test_class.call(**arguments)
        expect(test_class).to have_received(:new).with(**arguments)
      end

      it "does not pass the arguments to the instance's #call method" do
        test_instance = test_class.new
        allow(test_class).to receive(:new).and_return test_instance
        allow(test_instance).to receive(:call)

        test_class.call(**arguments)
        expect(test_instance).to have_received(:call).with no_args
      end
    end

    context "with a mix of positional and keyword arguments" do
      let(:positional_arguments) { [ double(:first_argument), double(:second_argument) ] }
      let(:keyword_arguments) { { third: double(:third_argument), fourth: double(:fourth_argument) } }

      it "passes the arguments to the initializer" do
        test_instance = test_class.new
        allow(test_class).to receive(:new).and_return test_instance

        test_class.call(*positional_arguments, **keyword_arguments)
        expect(test_class).to have_received(:new).with(*positional_arguments, **keyword_arguments)
      end

      it "does not pass the arguments to the instance's #call method" do
        test_instance = test_class.new
        allow(test_class).to receive(:new).and_return test_instance
        allow(test_instance).to receive(:call)

        test_class.call(*positional_arguments, **keyword_arguments)
        expect(test_instance).to have_received(:call).with no_args
      end
    end
  end

  describe '.with' do
  end

  describe '.[]' do
  end
end
