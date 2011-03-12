module PortfolioHelper
  def breadcrumb section_or_achievement
    [].tap { |result|
      achievement = section_or_achievement.is_a?(Achievement) && section_or_achievement
      section = achievement ? achievement.section : section_or_achievement
      result << link_to(t(".title.#{section}"), portfolio_path(section))
      if achievement
        result << achievement.subsection
        result << link_to(achievement.title, portfolio_path(@achievement))
      end
    }.compact.join(" / ").html_safe
  end
end
