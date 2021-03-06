module FinderTags
  include Radiant::Taggable
  # this is how you would include a Rails helper if you needed to access it in your class
  # include TextHelper
  
  tag 'finder' do |tag|
    tag.attr.each do |a,v|
      # logger.error("\n\n\n#{a} :: #{v}\n\n\n")
    end
    tag.expand
  end
  
  
  tag 'finder:url' do |tag|
    # p = find_page
    tag.attr.each do |a,v|
      # logger.error("\n\n\n#{a} :: #{v}\n\n\n")
    end
    if tag.attr['matches']
      tag.locals.finder = find_page(tag.attr['matches'])
    end
    tag.expand
  end
  
  tag 'finder:url:link' do |tag|
    return tag.locals.finder.url if tag.locals.finder
    tag.attr.each do |a,v|
      # logger.error("\n\n\n#{a} :: #{v}\n\n\n")
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
    if !tag.locals.finder
      tag.locals.finder = find_page(tag.attr['matches'])
    end
    if tag.locals.finder
      f = tag.locals.finder
      extra_attr = ""
      tag.attr.each do |a,v|
        extra_attr << " #{a}=\"#{v}\"" unless a.to_s == 'matches'
      end
      %{<a href="#{f.url}" title="#{f.title}"#{extra_attr}>#{f.title}</a>}
    else
      '<strong>Page Not Found</strong>'
    end
  end
  
  tag 'unless' do |tag|
    st = tag.attr['status']
    unless tag.locals.page.status.name.downcase == st.downcase
      tag.expand
    end
  end
  
  tag 'if' do |tag|
    st = tag.attr['status']
    if tag.locals.page.status.name.downcase == st.downcase
      tag.expand
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