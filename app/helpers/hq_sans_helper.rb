module HqSansHelper
  
    ### slices
  def new_hq_san_hq_slice_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :hq_slices_list, :partial => 'hq_sans/line/hq_slice', :object => HqSlice.new
    end 
  end 
 
  
end
