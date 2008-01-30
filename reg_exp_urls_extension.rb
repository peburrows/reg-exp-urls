class RegExpUrlsExtension < Radiant::Extension
  version "1.0"
  description "Allows for urls of available pages to be found via a regular expression"
  url "http://philburrows.com"
  
  def activate
    Page.send :include, FinderTags
  end
  
  def deactivate
  end
  
end