Test::Unit::TestCase.class_eval do
  class << self
    def should_display_tabs
      should "display tabs" do
        assert_select "ul.tabs"
      end      
    end
    
    def should_have_current_tab(name)
      should "have #{name} tab selected" do
        assert_select "li a.current", name
      end
    end
  end
end