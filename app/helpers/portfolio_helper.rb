module PortfolioHelper
  def breadcrumb section_or_achievement
    [].tap { |result|
      achievement = section_or_achievement.is_a?(Achievement) && section_or_achievement
      section = achievement ? achievement.section : section_or_achievement
      content_for :section, section
      result << link_to(t("home.index.links.#{section}"), portfolio_path(section))
      if achievement
        result << achievement.subsection
        result << link_to(achievement.title, portfolio_path(@achievement))
      end
    }.compact.join(" / ").html_safe
  end

  def description_with_outer_links achievement
    achievement.description.gsub(/(<a[^>]*)(>)/) { |c| "#{c[0]} target=\"_blank\"#{c[1]}" }.html_safe
  end
end
