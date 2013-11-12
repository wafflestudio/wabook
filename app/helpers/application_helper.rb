module ApplicationHelper
  def getTotalPageList(total_cnt, rowsPerPage)
	if((total_cnt % rowsPerPage)==0)
	  total_pages = total_cnt/rowsPerPage;
	else
	  total_pages = total_cnt/rowsPerPage - 1;
	end 

	totalPageList = (1..total_pages).to_a;
  end
end
