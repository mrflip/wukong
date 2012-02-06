

* Data window views: 
  - `win:length`
  - `win:length_batch`
  - `win:time`
  - `win:time_batch`
  - `win:time_length_batch`
  - `win:time_accum`
  - `win:ext_timed`
  - `ext:sort_window`
  - `ext:time_order`
  - `std:unique`
  - `std:groupwin`
  - `std:lastevent`
  - `std:firstevent`
  - `std:firstunique`
  - `win:firstlength`
  - `win:firsttime`

* Views that derive statistics: 
  - `std:size`
  - `stat:uni`
  - `stat:linest`
  - `stat:correl`
  - `stat:weighted_avg`
  
  
s

    [annotations]
    [expression_declarations]
    [context context_name]
    [insert into insert_into_def]
    select select_list
    from stream_def [as name] [, stream_def [as name]] [,...]
    [where search_conditions]
    [group by grouping_expression_list]
    [having grouping_search_conditions]
    [output output_specification]
    [order by order_by_expression_list]
    [limit num_rows]



* Filter criteria. The following operators are highly optimized through indexing and are the preferred means of filtering in high-volume event streams:
  - equals =
  - not equals !=
  - comparison operators < , > , >=, <=
  - ranges-- Ranges come in the following 4 varieties. The use of round () or square [] bracket dictates whether an endpoint is included or excluded. The low point and the high-point of the range are separated by the colon : character.
    - Open ranges that contain neither endpoint (low:high)
    - Closed ranges that contain both endpoints [low:high]. The equivalent 'between' keyword also defines a closed range.
    - Half-open ranges that contain the low endpoint but not the high endpoint [low:high)
    - Half-closed ranges that contain the high endpoint but not the low endpoint (low:high]
  - use the between keyword for a closed range where both endpoints are included
  - use the in keyword and round () or square brackets [] to control how endpoints are included
  - for inverted ranges use the not keyword and the between or in keywords
  - list-of-values checks using the in keyword or the not in keywords followed by a comma-separated list of values




* where clause
    ...where fraud.severity = 5 and amount > 500
    ...where (orderItem.orderId is null) or (orderItem.class != 10)		 
    ...where (orderItem.orderId = null) or (orderItem.class <> 10)		 
    ...where itemCount / packageCount > 10	

* aggregate -- `aggregate_function( [all | distinct] expression)`
  - group by
  - having
  - last, all, first
