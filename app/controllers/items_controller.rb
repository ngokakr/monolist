class ItemsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @items = []
    
    @keyword = params[:keyword]
    if @keyword
      results = RakutenWebService::Ichba::Item.search({
        keyword: @keyword,
        itemFlah: 1,
        hits: 20,
      })
      results.each do |result|
        item = Item.new(read(result))
        @items << item
      end
    end
  end
  
  private
  
  def read(result)
    code = result["itemCode"]
    name = result["itemName"]
    url = result["itemUrl"]
    image_url = result["mediumImageUrls"].first["imageUrl"].gsub('?_ex=128x128', '')
    
    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
end
