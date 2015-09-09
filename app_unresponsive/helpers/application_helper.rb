# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def ntp(input)
    number_to_currency input, :unit => "&pound;"
  end 

  def hide_search
    @hide_search = true
  end
  
  def hide_search?
    @hide_search
  end
  
  def hide_contact
    @hide_contact = true
  end
  
  def hide_contact?
    @hide_contact
  end
  
  def show_rss
    @show_rss = true
  end
  
  def show_rss?
    @show_rss
  end
	
	def determine_page_node
		if @page_node
			@current_page_node = @page_node
		elsif PageNode.controller_action(params[:controller], params[:action]).first
			@current_page_node = PageNode.controller_action(params[:controller], params[:action]).sort_by{|x| x.position}.first
		elsif PageNode.controller_action(params[:controller], "").first
			@current_page_node = PageNode.controller_action(params[:controller], "").sort_by{|x| x.position}.first
		else
			nil
		end
	end
	
	def check_box_tree_tag_2(nodes, name, name_method, child_method, selected=nil, options={})
    html = "<ul style='list-style-type:none; margin-left:10px; padding-left:0px;' class='check_box_tree'>"
    for node in nodes
      html << "<li>"
      children = child_method.call(node)
      if children.length > 0
        html << link_to_function("&nbsp;", "toggleDiv(this, 'check_box_tree_#{node.id}', 'down', 'up')", :class => "down")
        html << " "
      end
      html << label_tag("team_member_page_node_ids_#{node.id}", name_method.call(node))
     	html << check_box_tag(name, node.id, selected.include?(node.id), :class => "checkbox", :id => "team_member_page_node_ids_#{node.id}")
      if children.length > 0
      html << "<ul style='list-style-type:none; margin-left:10px; padding-left:0px; display: none;' id='check_box_tree_#{node.id}'>"
        html << check_box_tree_tag_2(children, name, name_method, child_method, selected, options)
      html << "</ul>"
      end
      html << "</li>"
    end
    html << "</ul>"

    return html
  end
  
  def options_from_tree_for_select(nodes, value_method, name_method, child_method, init, selected=nil, options={}, current_node=nil, level=0)
    html = ""
    if init
      unless options[:include_blank] == false
        if options[:include_blank] == true
          html << "<option></option>"    	
        else
          html << "<option value="">#{options[:include_blank].to_s}</option>"
        end
      end
    end
    for node in nodes.reject{|x| x.recycled? }
      unless node == current_node || node.ancestors.include?(current_node)
     		html << "\t<option value=\"#{value_method.call(node)}\""
        html << ' selected="selected"' if selected && selected == node.id
        html << ">"
        level.times do 
          html << "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        end
        html << name_method.call(node)
        html << "</option>\n"
      end
      html << options_from_tree_for_select(child_method.call(node), value_method, name_method, child_method, false, selected, options, current_node, level+1)
    end
    return html
  end
  
  def toggle_fieldset(legend, name=nil, open=false)
    name ||= legend.downcase.gsub(/\W/, '_')
    ret = ""
    ret += "<fieldset style=\"height:0px; #{open ? "display:none;" : ""}\" id=\"#{name}_1\">"
	  ret += "<legend style=\"cursor:pointer;cursor:hand\" onclick=\"$('#{name}_1').toggle(); $('#{name}_2').toggle();\" class=\"open\">#{legend}</legend>"
    ret += "</fieldset>"
    ret += "<fieldset id=\"#{name}_2\" style=\"#{open ? "" : "display:none;"}\">"
	  ret += "<legend style=\"cursor:pointer;cursor:hand\" onclick=\"$('#{name}_1').toggle(); $('#{name}_2').toggle();\" class=\"close\">#{legend}</legend>"
	  ret
  end
  
  def toggle_fieldset_controls()
    ret = ""
    ret += "<p class='toggle_fieldset_control'>"
    ret += link_to_function "Expland All", "$$('legend.open').each(function(s, index){s.parentNode.style.display='none';}); $$('legend.close').each(function(s, index){s.parentNode.style.display='';})"
    ret += "&nbsp;"
    ret += link_to_function "Collapse All", "$$('legend.close').each(function(s, index){s.parentNode.style.display='none';}); $$('legend.open').each(function(s, index){s.parentNode.style.display='';})"
    ret += "</p>"
    ret
  end
  
  def number_to_pounds(amount, options={})
    number_to_currency(amount, options.merge!(:unit => "&pound;"))  
  end
  
  # pass :behaviour => "hide" or behaviour => "highlight" to change page hidden / not found behaviour
  def link_to_page(link_text, page_name, options={})
    page_node = PageNode.find_by_name(page_name)
    if page_node
      if !page_node.display? && options[:behaviour] == "hide"
        return ""
      elsif !page_node.display? && options[:behaviour] == "highlight"
        return link_to(link_text, page_node.path, options.merge(:style => "border: 2px #FF0000 solid;"))
      else
        return link_to(link_text, page_node.path, options)
      end
    else
      if options[:behaviour] == "hide"
        return ""
      elsif options[:behaviour] == "highlight"
        return link_to(link_text, "/404.html", options.merge(:style => "border: 2px #FF0000 solid;"))
      else
        return link_to(link_text, "/404.html", options)
      end
    end
  end
  
  def shorten(text, length=150)
    if text.length > length
      text[0..length].split[0..-2].join(' ') + '...'
    else
      text
    end
  end
  
  require 'rss'
  require 'open-uri'
  def blog_feed
    begin
      #url = 'http://feeds.bhpinfosolutions.co.uk/news/category/legalnews/feed'
      url = 'http://feeds.atomcontentmarketing.co.uk/category/legalnews/feed'
      open(url) do |rss|
        feed = RSS::Parser.parse(rss)
        html = "<ul>"
        feed.items.first(3).shuffle.each_with_index do |item, index|
          if index.zero?
            html += "<li id=\"rss-feed-item-#{index}\">"
          else
            html += "</li><li id=\"rss-feed-item-#{index}\" style=\"display: none\">"
          end
            html += "Latest News: #{link_to(item.title, item.link, :popup => true)}"
          html += "</li>"
        end
        html += "</ul>"
        return raw html
      end
    rescue OpenURI::HTTPError
      html = ""
      return raw html
    end
  end
  
end
