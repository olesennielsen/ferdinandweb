module CampaignsHelper
  
  # helper method used to show the pageobjects in both the show and edit actions
  def show_pageobjects(objs)
    return_value = ''
    
    objs.each do |obj|
      if obj.object_type == 0 # Text
        return_value += create_text_object(obj)
      elsif obj.object_type == 1 # Picasa or Flickr Image
        return_value += create_image_object(obj)
      elsif obj.object_type == 2 # Youtube or Vimeo Video
        return_value += create_video_object(obj)
      end
    end    
    return return_value.html_safe
  end
  
  # show text objects with absolute position and color
  def create_text_object(obj)
    return content_tag(:div, content_tag(:p, obj.textobject), :class => Pageobject::COLOR[obj.color], :style => "position:absolute; 
      top: #{obj.y}px; left: #{obj.x}px;")
  end
  
  # image object from the object link
  def create_image_object(obj)
    return content_tag(:div, tag(:img, :src => obj.link), :style => "position:absolute; top: #{obj.y}px; left: #{obj.x}px;")
  end
  
  # video object embedded in an iframe from the object link
  def create_video_object(obj)
    return content_tag(:div, content_tag(:iframe, "", :src => obj.link, :width => "100%"), :style => "position:absolute; top: #{obj.y}px; left: #{obj.x}px;")
  end
  
  # huge helper method creating the links at the top of the edit page
  def create_page_links(page_number, page, pages, campaign)
    page_number = page_number.to_i
    
    if page_number == pages.count
      return content_tag(:div, content_tag(:p, link_to("Previous page", 
            edit_campaign_path(campaign, :page_number => page_number - 1), :class => "nice small radius blue button"), 
              :class => "four columns", :id => "previouspage") + 
          content_tag(:div, content_tag(:p, "#{page.number} / #{pages.count}"), 
              :class => "four columns", :id => "pagecounter") +
          content_tag(:div, content_tag(:p, (link_to "Add page", add_new_page_path(:id => @campaign.id, :page_number => page_number), 
            :class => "nice small radius green button")), 
              :class => "four columns", :id => "nextpage"))
    elsif page_number == 1      
      return content_tag(:div, content_tag(:p, "#{page.number} / #{pages.count}"), 
              :class => "four columns offset-by-four", :id => "pagecounter") +
          content_tag(:div, content_tag(:p, link_to("Next page", 
            edit_campaign_path(campaign, :page_number => page_number + 1), :class => "nice small radius blue button")),
              :class => "four columns", :id => "nextpage")
    else
      return content_tag(:div, content_tag(:p, link_to("Previous page", 
            edit_campaign_path(campaign, :page_number => page_number - 1), :class => "nice small radius blue button"), 
              :class => "four columns", :id => "previouspage") + 
          content_tag(:div, content_tag(:p, "#{page.number} / #{pages.count}"), 
              :class => "four columns", :id => "pagecounter") +
          content_tag(:div, content_tag(:p, link_to("Next page", 
            edit_campaign_path(campaign, :page_number => page_number + 1), :class => "nice small radius blue button")),
              :class => "four columns", :id => "nextpage"))
    end
  end
  
  
end
