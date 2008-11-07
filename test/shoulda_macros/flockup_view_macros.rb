Test::Unit::TestCase.class_eval do
  def self.should_have_search_form
    should_have_form_for 'searches_path' do
      assert_select "input[name='q']"
    end
  end
end
