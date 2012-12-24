module RatchetHelper

  # Accepts various types of title bar styles
  # :normal - full width and docked to the top of the viewport
  # :with_button - left or right aligned buttons (should be used for actions)
  #   * specify left, right or both as options[:position] for buttons
  # :with_directional_buttons - used for navigational purposes
  # :with_segmented_controller - house segmented controllers (w/ or w/o buttons)
  #   * specify both and either one, two or three segmented controllers w/ options[:amount]
  def title_bar(type, options = {})
    return if options[:visibility] == :hide
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
      if options[:position] == :left
        type = 
          (link_to title_bar_left, '#', :class => class_left) +
          (content_tag :h1, title_bar_name, :class => 'title')
      elsif options[:position] == :right
        type = 
          (content_tag :h1, (t 'name'), :class => 'title') +
          (link_to title_bar_right, '#', :class => class_right)
      elsif options[:position] == :both
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
        if options[:amount] == :one
          content_tag :li, (link_to "One", '#'), :class => 'active'
        elsif options[:amount] == :two
          (content_tag :li, (link_to "One", '#'), :class => 'active') +
          (content_tag :li, (link_to "Two", '#'))
        elsif options[:amount] == :three
          (content_tag :li, (link_to "One", '#'), :class => 'active') +
          (content_tag :li, (link_to "Two", '#')) +
          (content_tag :li, (link_to "Three", '#'))
        else # Default to three segmented controllers
          (content_tag :li, (link_to "One", '#'), :class => 'active') +
          (content_tag :li, (link_to "Two", '#')) +
          (content_tag :li, (link_to "Three", '#'))
        end
      unless options[:amount].blank?
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

  # Accepts :active and :hide option
  #   * Defaulted to display component
  def tab_bar_item(name, options = {})
    return if options[:visibility] == :hide
    css = (options[:active] == :active) ? 'tab-item active' : 'tab-item'
    entity =
      (content_tag :img, nil, :src => "assets/icon-#{name}.png", :class => 'tab-icon') +
      (content_tag :div, 'Label', :class => 'tab-label')
    item = link_to entity, ''
    content_tag :li, item, :class => css
  end

  # Accepts different count - :one, :two, :three
  # Accepts :hide option to remove component from view
  #   * Defaulted to display component
  def slider(count, options = {})
    return if options[:visibility] == :hide
    case count
    when :one
      image_1 = content_tag :img, nil, :src => "assets/slide-1.png"
      items =
        (content_tag :li, image_1)
    when :two
      image_1 = content_tag :img, nil, :src => "assets/slide-1.png"
      image_2 = content_tag :img, nil, :src => "assets/slide-2.png"
      items =
        (content_tag :li, image_1) +
        (content_tag :li, image_2)
    when :three
      image_1 = content_tag :img, nil, :src => "assets/slide-1.png"
      image_2 = content_tag :img, nil, :src => "assets/slide-2.png"
      image_3 = content_tag :img, nil, :src => "assets/slide-3.png"
      items =
        (content_tag :li, image_1) +
        (content_tag :li, image_2) +
        (content_tag :li, image_3)
    when :four
      image_1 = content_tag :img, nil, :src => "assets/slide-1.png"
      image_2 = content_tag :img, nil, :src => "assets/slide-2.png"
      image_3 = content_tag :img, nil, :src => "assets/slide-3.png"
      image_4 = content_tag :img, nil, :src => "assets/slide-4.png"
      items =
        (content_tag :li, image_1) +
        (content_tag :li, image_2) +
        (content_tag :li, image_3) +
        (content_tag :li, image_4)
    end
    list = content_tag :ul, items
    content_tag :div, list, :class => 'slider'
  end
end
