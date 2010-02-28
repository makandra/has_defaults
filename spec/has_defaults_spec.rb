require File.dirname(__FILE__) + "/spec_helper"

describe "has_defaults" do

  context "given a model with defaults" do

    before(:each) do
      @donut = create_donut
      @new_donut = Donut.new
    end
    
    it "should set defaults" do
      @new_donut.flavor.should == "cream"
      @new_donut.name.should == "Cream"
    end
    
    it "should merge multiple has_defaults directives" do
      @new_donut.maker.should == "Dunkin Donuts"
    end
    
    it "should set defaults only if attributes are blank" do
      @donut.flavor.should == "vanilla"
    end
    
    it "should return default value for an attribute" do
      @donut.default_for(:flavor).should == "cream"
    end
    
    it "should not set defaults on a saved record" do
      Donut.first.flavor.should == "vanilla"
    end
  
    it "should define #after_initialize" do
      @donut.should respond_to(:after_initialize)
    end
    
  end
  
  context "given a model without defaults" do
  
    it "should not define #after_initialize so initialization remains fast" do
      ModelWithoutDefaults.new.should_not respond_to(:after_initialize)
    end
  
  end
  
  private
  
  def create_donut(options={})
    Donut.create({:flavor => "vanilla", :name => "Vanilla Sky", :maker => "Mr. Baker"}.merge(options))
  end
  
end
