module Pagination
  def paginate(page, per_page = 5)
    page = page.to_i
    page = 1 if page < 1
    num_of_pages_f = count / per_page.to_f
    num_of_pages_i = num_of_pages_f.ceil
    page = num_of_pages_i if page > num_of_pages_f
    results = offset((page - 1) * per_page).limit(per_page)
    [results, page, num_of_pages_i]
  end

  ::ActiveRecord::Base.extend Pagination
end