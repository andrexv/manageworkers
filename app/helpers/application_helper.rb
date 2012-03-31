module ApplicationHelper
  
  def add_flash
    return raw('<div class="alert alert-info">'+flash[:alert]+'</div>') if flash[:notice].present?
    return raw('<div class="alert">'+flash[:alert]+'</div>') if flash[:alert].present?	
    return raw('<div class="alert alert-error">'+flash[:error]+'</div>') if flash[:error].present?	
    return raw('<div class="alert alert-success">'+flash[:success]+'</div>') if flash[:success].present?	
   end
end
