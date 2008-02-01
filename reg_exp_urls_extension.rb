class RegExpUrlsExtension < Radiant::Extension
  version "1.0"
  description "Allows for urls of available pages to be found via a regular expression. Very, very similar to &lt;r:find /&gt; tag."
  url "http://dev.philburrows.com/svn/radiant-extensions/reg_exp_urls/trunk"
  
  def activate
    Page.send :include, FinderTags
  end
  
  def deactivate
  end
  
end