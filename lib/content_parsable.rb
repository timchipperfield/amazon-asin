module ContentParsable
  def parse_title(raw_title)
    regex = %r{:\s(?<title>.+)\s*:}
    parsed = parse_raw_content(raw_title, regex)
    return "" unless parsed.present?

    parsed[:title]
  end

  def parse_category(raw_category)
    regex = %r{(?<category>\w+(.\w+)*)}
    parsed = parse_raw_content(raw_category, regex)
    return "" unless parsed.present?

    parsed[:category]
  end

  def parse_rank(raw_rank)
    regex = %r{(?<rank>#.+?)(?=\s\()}
    parsed = parse_raw_content(raw_rank, regex)
    # difficult to track field so allowing default value (below)
    return "unavailable" unless parsed.present?

    parsed[:rank]
  end

  def parse_dimensions(raw_dimensions)
    regex = %r{(?<dimensions>\w.+$)}
    parsed = parse_raw_content(raw_dimensions, regex)
    # difficult to track field so allowing default value (below)
    return "unavailable" unless parsed.present?

    parsed[:dimensions]
  end

  private

  def parse_raw_content(raw_content, regex)
    return "" unless raw_content

    raw_content.match(regex)
  end
end
