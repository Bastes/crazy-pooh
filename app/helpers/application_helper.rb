module ApplicationHelper
  def title(content)
    content_for(:title, content)
  end

  def specific_includes(&block)
    content_for(:specific_includes, capture(&block))
  end

  def errors_on(model, field = nil)
    errors = field.nil? ? model.errors.full_messages : model.errors[field]
    if errors.any?
      errors.map { |error|
        content_tag 'div', error, :class => 'error'
      }.join("\n").html_safe
    end
  end

  def static_content_tag(object_or_codename, tag_name, options = {})
    static_content = object_or_codename.is_a?(StaticContent) ?
      object_or_codename :
      StaticContent.find_by_codename(object_or_codename)
    if static_content
      options['data-edit-url'] = url_for([:edit, :admin, static_content]) if admin?
      content_tag(tag_name, static_content.content.html_safe, options)
    else
      Rails.logger.error("No static content for #{object_or_codename}")
      nil
    end
  end
end
