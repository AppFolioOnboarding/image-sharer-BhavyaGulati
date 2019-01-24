module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      collection :tag_elements, locator: '.js-tag_list', item_locator: '.js-tag_list_element'

      def image_url
        node.find('img')[:src]
      end

      def tags
        tag_elements.map(&:text)
      end

      def delete
        node.click_on('Delete')
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        node.click_on('Delete')
        alert_box = node.driver.browser.switch_to.alert
        alert_box.accept
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        node.click_on('See all Images')
        window.change_to(IndexPage)
      end
    end
  end
end
