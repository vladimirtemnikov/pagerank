class PageParser
  FILTER_LINK_REGEXP = /^((?!javascript)(?!#)[\w\S])*$/.freeze

  def main_page_links
    @_main_page_links = links_from_page_with_count(parsed_content(get_html($inputs.main_link)), $inputs.links_count)
  end

  def general_page_links(link)
    links_from_page(parsed_content(get_html(link)))
  end

  def links_from_page(content)
    links = content.css('a').map { |link| link[:href] }
    okay_links = links.find_all { |link| link && link =~ FILTER_LINK_REGEXP }
    if block_given?
      yield okay_links
    else
      okay_links.map { |link| link =~ /^\/.*/ ? $inputs.main_link + link : link }
    end
  end

  private

  def get_html(link)
    abort 'Неверный формат ссылки' unless valid_link?(link)

    begin
      Net::HTTP.get URI(link)
    rescue Timeout::Error, SocketError
      abort 'Проблемы с интернет соединением'
    end
  end

  def valid_link?(link)
    URI.parse(link).host
  end

  def parsed_content(content)
    Nokogiri::HTML(content)
  end

  def links_from_page_with_count(content, count)
    links_from_page(content) do |okay_links|
      okay_links.uniq.take(count).map { |link| link =~ /^\/.*/ ? $inputs.main_link + link : link }
    end
  end
end
