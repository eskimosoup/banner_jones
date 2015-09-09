module NavigationHelper
  
  # OPTIONS
  # :type => "horizontal" || "vertical" || "columns" (default = horizontal)
  # :nodes => PageNodes || nil (default = nil) - will only have an affect on the untiered horizontal navigation
  # :tiers => true || false (default = true)
  # :columns => 3 (default = 2) - will alters "columns" type navigation
  def navigation(options={})
    options[:tiers] = true if options[:tiers] == nil
    options[:nodes] ||= PageNode.roots.navigation
    options[:type] ||= "horizontal"
    options[:columns] ||= 2
    render "shared/navigation/#{options[:type]}", :nodes => options[:nodes], :options => options
  end
  
end
