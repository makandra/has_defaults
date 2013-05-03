require "spec_helper"

describe HasDefaults::ActiveRecordExt do

  context "given a model with defaults" do

    describe 'initialization' do

      it "should set defaults" do
        new_donut = Donut.new
        new_donut.flavor.should == "cream"
        new_donut.name.should == "Cream"
      end

      it "should use setters methods to set the defaults" do
        new_donut = Donut.new
        new_donut.instance_variable_get('@flavor_setter_called').should be_true
      end

      it "should call procs in the model context when given as defaults" do
        new_donut = Donut.new
        new_donut.weight.should == 'a lot'
      end

      it "should merge multiple has_defaults directives" do
        new_donut = Donut.new
        new_donut.flavor.should == "cream"
        new_donut.maker.should == "Dunkin Donuts"
      end

      it 'should not assign attributes multiple times when there are multiple has_defaults directives (bugfix)' do
        Donut.should_receive(:global_health_benefits).once
        Donut.new
      end

      it "should set defaults only if attributes are nil" do
        donut = Donut.new(:flavor => 'vanilla')
        donut.flavor.should == "vanilla"
      end

      it "should not set a default on an attribute that is set to an empty string" do
        donut = Donut.new(:flavor => '')
        donut.flavor.should == ''
      end

      it "should use getters methods to check if an attribute is nil" do
        new_donut = Donut.new
        new_donut.instance_variable_get('@flavor_getter_called').should be_true
      end

      it "should return default value for an attribute" do
        Donut.new.default_for(:flavor).should == "cream"
      end

      it "should not set defaults when loading a saved record" do
        Donut.create(:flavor => "vanilla")
        Donut.first.flavor.should == "vanilla"
      end

      it "should define #after_initialize in Rails 2, but not Rails 3 (this method must be defined so after_initialize callbacks run)" do
        donut = Donut.new
        if Rails.version.to_i < 3
          donut.should respond_to(:after_initialize)
        else
          donut.should_not respond_to(:after_initialize)
        end
      end

      it "should not redefine defaults in its superclass" do
        pastry = Pastry.new
        pastry.maker.should == 'Mom'
        pastry.default_for(:maker).should == 'Mom'
      end

      it "should respect defaults from its superclass" do
        donut = Donut.create
        donut.main_ingredient.should == 'flour'
        donut.maker.should_not == 'Mom'
      end

    end

    describe '#default_for' do

      it "should return the default value for the given attribute" do
        Donut.new.default_for(:flavor).should == 'cream'
      end

      it 'should evaluate the default value if it is a lambda' do
        Donut.new.default_for(:weight).should == 'a lot'
      end

    end

  end

  context "given a model without defaults" do

    it "should not define #after_initialize so initialization remains fast" do
      ModelWithoutDefaults.new.should_not respond_to(:after_initialize)
    end

  end

end
