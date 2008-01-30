module FinderTags
  include Radiant::Taggable
  # this is how you would include a Rails helper if you needed to access it in your class
  # include TextHelper
  
  tag 'finder' do |tag|
    tag.attr.each do |a,v|
      logger.error("\n\n\n#{a} :: #{v}\n\n\n")
    end
    tag.expand
  end
  
  
  tag 'finder:url' do |tag|
    # p = find_page
    tag.attr.each do |a,v|
      logger.error("\n\n\n#{a} :: #{v}\n\n\n")
    end
    if tag.attr['matches']
      tag.locals.finder = find_page(tag.attr['matches'])
    end
    tag.expand
  end
  
  tag 'finder:url:link' do |tag|
    return tag.locals.finder.url if tag.locals.finder
    tag.attr.each do |a,v|
      logger.error("\n\n\n#{a} :: #{v}\n\n\n")
    end
    tag.locals.finder = find_page(tag.attr['matches'])
    if tag.locals.finder
      f = tag.locals.finder
      f.url
    else
      'page-not-found'
    end
  end
  
  tag 'finder:url:html_link' do |tag|
    # raise StandardTags::TagError.new("`finder:url:html_link' tag must contain a `matches' attribute.") unless tag.attr.has_key?('matches')
    tag.locals.finder = find_page(tag.attr['matches'])
    if tag.locals.finder
      f = tag.locals.finder
      %{<a href="#{f.url}" title="#{f.title}">#{f.title}</a>}
    else
      '<strong>No Page Was Found To Match That URL</strong>'
    end
  end
  
  
private
  
  def find_page(string)
    @all_pages = @all_pages || Page.find(:all, :include => [:parent])
    s = string.sub(/\$$/, '\/?$') # add optional endslash
    @pattern = Regexp.new(s)
    page = nil
    @all_pages.each do |p|
      break if page
      # logger.error("#{p.url}\n++++++++++++++++++++++++++++++++++++++\n")
      if p.url.match(@pattern)
        page = p
      end
    end
    page
  end

end