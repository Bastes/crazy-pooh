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

  def achievement_section_tag(section, achievements)
    options = { :id => 'achievements' }
    if admin?
      options['data-new-url'] = new_admin_achievement_path(:section => section)
    end
    content_tag(:div, options) do
      unless achievements.nil?
        content_tag(:ul, :id => 'subsections') do
          achievements.group_by(&:subsection).map { |subsection|
            achievement_subsection_tag(section, *subsection)
          }.join("\n").html_safe
        end
      end
    end
  end

  def achievement_subsection_tag(section, subsection, achievements)
    content_tag(:li, :id => "subsection_#{subsection}") do
      options = { :class => 'achievements' }
      if admin?
        options['data-new-url'] = new_admin_achievement_path(
          :section => section,
          :subsection => subsection)
      end
      ( content_tag(:h2, "[#{subsection}]") + "\n" +
        content_tag(:ul, options) do
          achievements.map { |achievement|
            achievement_thumbnail_tag(achievement)
          }.join("\n").html_safe
        end).html_safe
    end.html_safe
  end

  def achievement_thumbnail_tag(achievement)
    options = {}
    if admin?
      options['data-edit-url'] = url_for([:edit, :admin, achievement])
      options['data-delete-url'] = url_for([:admin, achievement])
    end
    content_tag(:li, options) do
      link_to(portfolio_path(achievement)) do
        image_tag(achievement.exhibit.url(:thumbnail),
                  :alt => achievement.title).html_safe
      end.html_safe
    end.html_safe
  end

  def portfolio_path(section_or_achievement)
    if section_or_achievement.is_a?(Achievement)
      portfolio_achievement_path(
        :section => section_or_achievement.section,
        :subsection => section_or_achievement.subsection,
        :title => section_or_achievement.title)
    else
      portfolio_section_path :section => section_or_achievement
    end
  end

  def external_links_tag(external_links)
    options = { :id => 'external_links' }
    options['data-new-url'] = new_admin_external_link_path if admin?
    content_tag(:ul, options) do
      external_links.group_by(&:section).map { |section|
        external_link_section_tag(*section)
      }.join("\n").html_safe
    end.html_safe
  end

  def external_link_section_tag(section, external_links)
    content_tag(:li, :id => "section_#{section}", :class => 'section') do
      options = {}
      if admin?
        options['data-new-url'] = new_admin_external_link_path(
          :section => section)
      end
      ( content_tag(:h2, "[#{section}]") + "\n" +
        content_tag(:ul, options) do
          external_links.map { |external_link|
            external_link_tag(external_link)
          }.join("\n").html_safe
        end ).html_safe
    end.html_safe
  end

  def external_link_tag(external_link)
    options = {}
    if admin?
      options['data-edit-url'] = url_for([:edit, :admin, external_link])
    end
    content_tag(:li, options) do
      link_to external_link.url, :title => external_link.description, :target => '_blank' do
        ( h(external_link.label) +
          if external_link.banner.file?
            ( "\n" +
              image_tag(external_link.banner.url, :alt => external_link.label)
            ).html_safe
          end ).html_safe
      end
    end
  end
end
