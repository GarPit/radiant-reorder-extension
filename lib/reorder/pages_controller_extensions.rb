module Reorder::PagesControllerExtensions

  %w{move_higher move_lower move_to_top move_to_bottom}.each do |action|
    define_method action do
      @page = Page.find(params[:id])
      @page.parent.reload.children.reload
      @page.send(action)
      response_for :update
    end
  end

  protected

  def load_models
    if params[:page_id]
      page = Page.find(params[:page_id])
      self.models = if paginated? 
        model_class.paginate(pagination_parameters) 
      else
        if page.auto_order_children 
          Page.reflections[:children].options[:order] = "published_at DESC"
        end
        model_class.all 
      end
      Page.reflections[:children].options[:order] = "position ASC"
    else
      super
    end
  end
  
end
