# encoding: UTF-8
require 'will_paginate/view_helpers' 
WillPaginate.per_page = 10
WillPaginate::ViewHelpers.pagination_options[:previous_label] = "← Prev"
WillPaginate::ViewHelpers.pagination_options[:page_links] = false
