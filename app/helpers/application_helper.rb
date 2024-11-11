module ApplicationHelper
  def sortable_column(title, column_name, controller_name)
    link_to title, "#", data: {
      controller: controller_name,
      action: "click->#{controller_name}#sort",
      sort_column: column_name
    }
  end
end
