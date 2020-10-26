module Pagination
  def paginate(page, opts = {})
    per_page = opts[:per_page] || 5
    is_filtered = opts[:filtered].present?
    page = page.to_i
    page = 1 if page < 1
    # handle edgecase when count returns hash
    num_of_pages_f = is_filtered ? count.length / per_page.to_f : count / per_page.to_f
    num_of_pages_i = num_of_pages_f.ceil
    page = num_of_pages_i if page > num_of_pages_f && page != 1
    results = offset((page - 1) * per_page).limit(per_page)
    [results, page, num_of_pages_i]
  end

  ::ActiveRecord::Base.extend Pagination
end