require File.dirname(__FILE__) + '/../test_helper'

class RegExpUrlsExtensionTest < Test::Unit::TestCase
  
  # Replace this with your real tests.
  def test_this_extension
    flunk
  end
  
  def test_initialization
    assert_equal File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'reg_exp_urls'), RegExpUrlsExtension.root
    assert_equal 'Reg Exp Urls', RegExpUrlsExtension.extension_name
  end
  
end
