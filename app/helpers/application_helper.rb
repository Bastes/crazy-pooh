module ApplicationHelper
  def title(content)
    content_for(:title, content)
  end

  def errors_on(model, field = nil)
    errors = field.nil? ? model.errors.full_messages : model.errors[field]
    if errors.any?
      errors.map { |error|
        content_tag 'div', error, :class => 'error'
      }.join("\n").html_safe
    end
  end
end
