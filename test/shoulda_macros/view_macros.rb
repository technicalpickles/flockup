Test::Unit::TestCase.class_eval do
  class << self
    def should_not_link_to(href_expression)
      should_link_to(href_expression, 0)
    end
    
    def should_link_to(href_expression, count = 1)
      should "display #{count} link#{'s' if count == 0 || count > 1} to #{href_expression.inspect}" do
        instantiate_variables_from_assigns do
          href =  eval(href_expression, self.send(:binding), __FILE__, __LINE__)
          assert_select "a[href=#{href}]", count
        end  
      end
    end

      def should_have_form_for(action_expression, &block)
      should "have form to #{action_expression}" do
        instantiate_variables_from_assigns do
          action =  eval(action_expression, self.send(:binding), __FILE__, __LINE__)

          assert_select "form[action=#{action}]" do
            block.bind(self).call if block
          end
        end
      end
    end
    
  end
end
