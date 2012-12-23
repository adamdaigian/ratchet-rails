module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  # Accepts various types of title bar styles
  # :normal - full width and docked to the top of the viewport
  # :with_button - left or right aligned buttons (should be used for actions)
  #   * specify left, right or both as option for buttons
  # :with_directional_buttons - used for navigational purposes
  # :with_segmented_controller - house segmented controllers (w/ or w/o buttons)
  #   * specify both and either one, two or three segmented controllers
  def title_bar(type, options = {})
    title_bar_name  = t "#{controller_name}.title_bar.name"
    title_bar_left  = t "#{controller_name}.title_bar.left"
    title_bar_right = t "#{controller_name}.title_bar.right"
    class_left = 'button'
    class_right = 'button'
    case type
    when :normal
      type = content_tag :h1, title_bar_name, :class => 'title'
    when :with_buttons, :with_directional_buttons
      unless type == :with_buttons
        class_left  = 'button-prev'
        class_right = 'button-next'
      end
      if options == :left
        type = 
          (link_to title_bar_left, '#', :class => class_left) +
          (content_tag :h1, title_bar_name, :class => 'title')
      elsif options == :right
        type = 
          (content_tag :h1, (t 'name'), :class => 'title') +
          (link_to title_bar_right, '#', :class => class_right)
      elsif options == :both
        type =
          (link_to title_bar_left, '#', :class => class_left) +
          (content_tag :h1, title_bar_name, :class => 'title') +
          (link_to title_bar_right, '#', :class => class_right)
      else # Default to options[:right]
        type = 
          (content_tag :h1, title_bar_name, :class => 'title') +
          (link_to title_bar_right, '#', :class => class_right)
      end
    when :with_segmented_controller
      segmented_controller =
        if options == :one
          content_tag :li, (link_to "One", '#'), :class => 'active'
        elsif options == :two
          (content_tag :li, (link_to "One", '#'), :class => 'active') +
          (content_tag :li, (link_to "Two", '#'))
        elsif options == :three
          (content_tag :li, (link_to "One", '#'), :class => 'active') +
          (content_tag :li, (link_to "Two", '#')) +
          (content_tag :li, (link_to "Three", '#'))
        else # Default to three segmented controllers
          (content_tag :li, (link_to "One", '#'), :class => 'active') +
          (content_tag :li, (link_to "Two", '#')) +
          (content_tag :li, (link_to "Three", '#'))
        end
      unless options.blank?
        type =
          (link_to title_bar_left, '#', :class => class_left) +
          (content_tag :ul, segmented_controller, :class => 'segmented-controller') +
          (link_to title_bar_right, '#', :class => class_right)
      else
        type =
          (content_tag :ul, segmented_controller, :class => 'segmented-controller')
      end
    end
    content_tag :header, type, :class => 'bar-title'
  end

  # Accepts :active option
  def tab_bar_item(name, options = {})
    css = (options == :active) ? 'tab-item active' : 'tab-item'
    entity =
      (content_tag :img, nil, :src => "assets/icon-#{name}.png", :class => 'tab-icon') +
      (content_tag :div, 'Label', :class => 'tab-label')
    item = link_to entity, ''
    content_tag :li, item, :class => css
  end
end
