class PageContentsController < ApplicationController
  
  def show
    page_content = PageContent.find(params[:id])
    redirect_to url_for(page_content.page_node.path)
  end

end
