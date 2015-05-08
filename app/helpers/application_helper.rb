module ApplicationHelper
  def full_title page_title
    base_title = "DATN"
    if page_title.blank?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(sort: column, direction: direction, page: nil), {class: css_class}
  end

  def bootstrap_class_for flash_type
    _type = flash_type.to_sym
    case _type
    when :success
      "alert-success"
    when :error
      "alert-error"
    when :alert
      "alert-warning"
    when :notice
      "alert-info"
    when :danger
      "alert-error"
    else
      flash_type.to_s
    end
  end
end
