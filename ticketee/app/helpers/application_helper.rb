module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Ticketee").join(" - ")
      end
    end
  end

  def error_messages_for(object, field)
    content_tag(:p, class: "text-red-500 text-xs italic mt-2") do
      object.errors.full_messages_for(field).first
    end
  end
end
