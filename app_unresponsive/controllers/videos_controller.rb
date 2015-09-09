class VideosController < ApplicationController

  def show
    if request.env["HTTP_REFERER"] && request.env["HTTP_REFERER"].include?("/page/")
      page_url = request.env["HTTP_REFERER"].scan(/\/page\/([\w\d\-_]*)/i).first.first
      @page_node = PageNode.find_by_url(page_url)
    end
    @video = Video.find(params[:id])
  end
  
  def index
    @videos = Video.active.paginate(:page => params[:page])
  end
  
end
