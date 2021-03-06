module PageObjects
  module Extensions
    module ElementInlineErrorMessage
      def error_message
        parent = find_parent

        Capybara.using_wait_time(0) do
          parent.find('.js-help-block').text
        rescue Capybara::ElementNotFound
          ''
        end
      end

      private

      def find_parent
        node.find(:xpath, "ancestor::*[contains(concat(' ',normalize-space(@class), ' '),' new_image ')][1]")
      end
    end
  end
end
