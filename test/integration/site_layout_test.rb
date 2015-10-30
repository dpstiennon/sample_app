require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
   test "layout links" do
     get root_path
     assert_template 'static_pages/home'
     assert_href root_path, 2
     assert_href help_path
     assert_href about_path
     assert_href contact_path
   end

  def assert_href(path, count = 1)
     assert_select "a[href=?]", path, count
  end
end
