class PageNodesController < ApplicationController

  include PageContentsHelper

  def show
    @page_node = PageNode.active.find(params[:id])

    # try and call the helper method matching the layout
    begin
      send(@page_node.likely_layout)
    rescue Exception => e
      logger.info e.to_yaml
    end

    if @page_node.controller? && @page_node.action?
      redirect_to url_for(:controller => @page_node.controller, :action => @page_node.action)
      return
    elsif @page_node.controller?
      redirect_to url_for(@page_node.controller)
      return
    end

    if @page_node.layout == "calculator"
      @fa = LegalAidRequest.new
    elsif @page_node.layout == "service_quote"
      @conveyancing_quote = ConveyancingQuote.new
    end

    if @page_node.alternate_header?
      render :layout => "wealth_management"
    end
  end

  def update_type_fields
    render :update  do |page|
      page[:type_fields].replace :partial => "conveyancing_quotes/form/" + ConveyancingQuote.conveyancing_types_to_form_partial(params[:conveyancing_type])
    end
  end

  def splash
    @page_node = PageNode.find(params[:id])
    @page_content = @page_node.active_content
    unless @page_content.banner_image?
      redirect_to url_for(@page_node.path)
      return
    end
  end

end
